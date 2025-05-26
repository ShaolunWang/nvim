M = {}

function M.qf_to_arglist()
	-- qf weirdness: id = 0 gets id of quickfix list nr
	local qflist = vim.fn.getqflist()
	for _, v in ipairs(qflist) do
		local filename = vim.fn.fnamemodify(vim.fn.bufname(v.bufnr), '%:.')
		local pos = { 0, v.lnum, v.col, 0 }
		M.arg_add(filename, pos)
	end
end
function M.arg_edit()
	local tbl = vim.fn.argv()
	---@diagnostic disable-next-line: param-type-mismatch
	if vim.tbl_isempty(tbl) then
		return
	end
	---@diagnostic disable-next-line: param-type-mismatch
	vim.ui.select(tbl, {
		prompt = 'Arglist jump',
		format_item = function(item)
			return '> ' .. item
		end,
	}, function(choice)
		M.arg_open(choice)
	end)
end

function M.arg_add(path, pos)
	local file_vimfmt = path .. ':' .. pos[2] .. ':' .. pos[3]
	vim.cmd('argadd ' .. file_vimfmt)
end
function M.arg_open(choice)
	vim.print(choice)
	---@diagnostic disable-next-line: param-type-mismatch
	local choice_tbl = vim.split(choice, ':')
	if choice ~= nil and string.find(choice, ':') ~= nil then
		local command = 'argedit +' .. choice_tbl[2] .. ' ' .. choice_tbl[1] .. ' | argdedupe'
		vim.cmd(command)
	end
end
return M
