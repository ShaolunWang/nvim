-- :fennel:1704453155
local M = {}
local border = {
	{ '\240\159\173\189', 'FloatBorder' },
	{ '\226\150\148', 'FloatBorder' },
	{ '\240\159\173\190', 'FloatBorder' },
	{ '\226\150\149', 'FloatBorder' },
	{ '\240\159\173\191', 'FloatBorder' },
	{ '\226\150\129', 'FloatBorder' },
	{ '\240\159\173\188', 'FloatBorder' },
	{ '\226\150\143', 'FloatBorder' },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
	opts = (opts or {})
	opts.border = (opts.border or border)
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
M.c = vim.tbl_deep_extend(
	'force',
	{},
	vim.lsp.protocol.make_client_capabilities(),
	((has_cmp and cmp_nvim_lsp.default_capabilities()) or {}),
	{},
	{ textDocument = { foldingRange = { lineFoldingOnly = true, dynamicRegistration = false } } }
)
M.goto_definition = function(split_cmd)
	local util = vim.lsp.util
	local log = require('vim.lsp.log')
	local api = vim.api
	local function handler(_, result, ctx)
		if (result == nil) or vim.tbl_isempty(result) then
			local _0 = (log.info() and log.info(ctx.method, 'No location found'))
			return nil
		else
		end
		if split_cmd then
			vim.cmd(split_cmd)
		else
		end
		if vim.tbl_islist(result) then
			util.jump_to_location(result[1])
			if #result > 1 then
				util.set_qflist(util.locations_to_items(result))
				api.nvim_command('copen')
				return api.nvim_command('wincmd p')
			else
				return nil
			end
		else
			return util.jump_to_location(result)
		end
	end
	return handler
end
M.lsp_handlers = {
	['textDocument/definition'] = M.goto_definition('split'),
	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}
M.c.textDocument.completion.completionItem.snippetSupport = true
M.c.textDocument.completion.completionItem.resolveSupport =
	{ properties = { 'documentation', 'detail', 'additionalTextEdits' } }
return M
