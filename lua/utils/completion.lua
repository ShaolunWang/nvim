-- Original Ideia and Implementation
-- https://github.com/lukas-reineke/cmp-rg

local M =  {}
local utils = require("coq_3p.utils")
function M.coq_rg()
COQsources = COQsources or {}
COQsources[utils.new_uid(COQsources)] = {
	name = "RG",
	fn = function(args, callback)
		local pattern = "[\\w_-]+"
		local additional_arguments = ""
		local context_before = 1
		local context_after = 3
		local debounce = 100
		local cwd = vim.fn.getcwd()

		local _, col = unpack(args.pos)
		local q = utils.cword(args.line, col)

		local quote = "'"
		if vim.o.shell == "cmd.exe" then
			quote = '"'
		end

		local seen = {}
		local items = {}
		local context = {}
		local documentation_to_add = 0

		local running_job_id = 0
		local timer = vim.loop.new_timer()
		local json_decode = vim.fn.json_decode
		if vim.fn.has("nvim-0.6") == 1 then
			json_decode = vim.json.decode
		end

		local function on_event(job_id, data, event)
			if event == "stdout" then
				for _, entry in ipairs(data) do
					if entry ~= "" then
						local ok, result = pcall(json_decode, entry)
						if
							not ok
							or result.type == "end"
							or (vim.tbl_contains({ "context", "match" }, result.type) and not result.data.lines.text)
						then
							context = {}
							documentation_to_add = 0
						elseif result.type == "context" then
							local documentation = result.data.lines.text:gsub("\n", "")
							table.insert(context, documentation)
							if documentation_to_add > 0 then
								local d = { items[#items].detail }
								table.insert(d, documentation)
								documentation_to_add = documentation_to_add - 1

								if documentation_to_add == 0 then
									local min_indent = 1e309
									for i = 4, #d, 1 do
										if d[i] ~= "" then
											local _, indent = string.find(d[i], "^%s+")
											min_indent = math.min(min_indent, indent or 0)
										end
									end
									for i = 4, #d, 1 do
										d[i] = d[i]:sub(min_indent)
									end
									table.insert(d, "```")
									items[#items].detail = table.concat(d, "\n")
								end
							end
						elseif result.type == "match" then
							local label = result.data.submatches[1].match.text
							if label and not seen[label] then
								local detail = { result.data.path.text, "```" }
								for i = context_before, 0, -1 do
									table.insert(detail, context[i])
								end
								local match_line = result.data.lines.text:gsub("\n", "") .. "  <--"
								table.insert(detail, match_line)
								table.insert(items, {
									label = label,
									word = label,
									detail = table.concat(detail, "\n"),
									kind = vim.lsp.protocol.CompletionItemKind.Text,
								})
								documentation_to_add = context_after
								seen[label] = true
							end
						end
					end
				end
				callback({ items = items, isIncomplete = true })
			end

			if event == "stderr" and debug then
				vim.cmd("echohl Error")
				vim.cmd('echomsg "' .. table.concat(data, "") .. '"')
				vim.cmd("echohl None")
			end

			if event == "exit" then
				callback({ items = items, isIncomplete = false })
			end
		end

		timer:stop()
		timer:start(
			debounce or 100,
			0,
			vim.schedule_wrap(function()
				vim.fn.jobstop(running_job_id)
				running_job_id = vim.fn.jobstart(
					string.format(
						"rg --heading --json --word-regexp -B %d -A %d --color never %s %s%s%s%s .",
						context_before,
						context_after,
						additional_arguments,
						quote,
						q,
						pattern,
						quote
					),
					{
						on_stderr = on_event,
						on_stdout = on_event,
						on_exit = on_event,
						cwd = cwd or vim.fn.getcwd(),
					}
				)
			end)
		)
	end,
}
end
return M
