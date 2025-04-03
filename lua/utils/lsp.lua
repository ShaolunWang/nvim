local M = {}
local border = {
	{ '┌', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '┐', 'FloatBorder' },
	{ '│', 'FloatBorder' },
	{ '┘', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '└', 'FloatBorder' },
	{ '│', 'FloatBorder' },
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local p = vim.lsp.protocol.make_client_capabilities()
M.c = vim.tbl_deep_extend('force', p, {
	textDocument = {
		foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
	},
})

function M.goto_definition(split_cmd)
	local util = vim.lsp.util
	local log = require('vim.lsp.log')
	local api = vim.api

	-- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, 'No location found')
			return nil
		end
		if split_cmd then
			vim.cmd(split_cmd)
		end

		if vim.islist(result) then
			util.show_document(result[1])

			if #result > 1 then
				util.set_qflist(util.locations_to_items(result))
				api.nvim_command('copen')
				api.nvim_command('wincmd p')
			end
		else
			util.show_document(result)
		end
	end

	return handler
end

M.lsp_handlers = {
	['textDocument/hover'] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{ border = border, contentFormat = { 'plaintext' }, dynamicRegistration = true }
	),
	['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	['textDocument/definition'] = M.goto_definition('split'),
}
M.c.textDocument.completion.completionItem.snippetSupport = true
M.c.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	},
}

M.c.workspace = {
	didChangeWatchedFiles = {
		dynamicRegistration = true,
	},
}
function M.code_actions()
	local function apply_specific_code_action(res)
		-- vim.notify(vim.inspect(res))
		vim.lsp.buf.code_action({
			filter = function(action)
				return action.title == res.title
			end,
			apply = true,
		})
	end

	local actions = {}

	actions['Goto Definition'] = { priority = 100, call = vim.lsp.buf.definition }
	actions['Goto Implementation'] = { priority = 200, call = vim.lsp.buf.implementation }
	actions['Show References'] = { priority = 300, call = vim.lsp.buf.references }
	actions['Rename'] = { priority = 400, call = vim.lsp.buf.rename }

	local bufnr = vim.api.nvim_get_current_buf()
	local params = vim.lsp.util.make_range_params(0, 'utf-8')

	params.context = {
		triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
		diagnostics = vim.diagnostic.get(),
	}

	vim.lsp.buf_request(bufnr, 'textDocument/codeAction', params, function(_, results, _, _)
		if not results or #results == 0 then
			return
		end
		for i, res in ipairs(results) do
			local prio = 10
			if res.isPreferred then
				if res.kind == 'quickfix' then
					prio = 0
				else
					prio = 1
				end
			end
			actions[res.title] = {
				priority = prio,
				call = function()
					apply_specific_code_action(res)
				end,
			}
		end
		local items = {}
		for t, action in pairs(actions) do
			table.insert(items, { title = t, priority = action.priority })
		end
		table.sort(items, function(a, b)
			return a.priority < b.priority
		end)
		local titles = {}
		for _, item in ipairs(items) do
			table.insert(titles, item.title)
		end
		vim.ui.select(titles, {}, function(choice)
			if choice == nil then
				return
			end
			actions[choice].call()
		end)
	end)
end
return M
