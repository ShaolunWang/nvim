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
local has_cmp, cmp_nvim_lsp = pcall(require, 'bink.cmp')
M.c = vim.tbl_deep_extend(
	'force',
	{},
	p,
	has_cmp and cmp_nvim_lsp.get_lsp_capabilities(p) or {},
	--	has_cmp and cmp_nvim_lsp.lsp_ensure_capabilities() or {},
	{},
	{
		textDocument = {
			foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
		},
	}
)

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
			util.jump_to_location(result[1])

			if #result > 1 then
				util.set_qflist(util.locations_to_items(result))
				api.nvim_command('copen')
				api.nvim_command('wincmd p')
			end
		else
			util.jump_to_location(result)
		end
	end

	return handler
end

M.lsp_handlers = {
	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
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
M.c.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
M.c.workspace = {
	didChangeWatchedFiles = {
		dynamicRegistration = true,
	},
}

return M
