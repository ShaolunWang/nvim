-- :fennel:1704812508
local function _1_()
	return require('clangd_extensions').setup({
		extensions = {
			ast = {
				highlights = { detail = 'Comment' },
				kind_icons = {
					Compound = '\238\170\139',
					PackExpansion = '\238\169\188',
					Recovery = '\238\170\135',
					TemplateParamObject = '\238\170\146',
					TemplateTemplateParm = '\238\170\146',
					TemplateTypeParm = '\238\170\146',
					TranslationUnit = '\238\171\169',
				},
				role_icons = {
					declaration = '\238\170\140',
					expression = '\238\169\177',
					specifier = '\238\174\134',
					statement = '\238\170\134',
					['template argument'] = '\238\170\146',
					type = '\238\173\163',
				},
			},
			autoSetHints = true,
			inlay_hints = {
				highlight = 'Comment',
				max_len_align_padding = 1,
				only_current_line_autocmd = 'CursorHold',
				other_hints_prefix = '=> ',
				parameter_hints_prefix = '<- ',
				priority = 100,
				right_align_padding = 7,
				show_parameter_hints = true,
				max_len_align = false,
				only_current_line = false,
				right_align = false,
			},
			memory_usage = { border = 'none' },
			symbol_info = { border = 'none' },
		},
	})
end
return {
	{ 'p00f/clangd_extensions.nvim', config = _1_, ft = { 'cpp', 'h' } },
	{ 'mrcjkb/rustaceanvim', version = '^3', ft = 'rust' },
}
