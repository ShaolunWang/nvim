local kind_icons = {
	Text = '',
	Method = '󰆧',
	Function = '󰊕',
	Constructor = '',
	Field = '󰇽',
	Variable = '󰂡',
	Class = '󰠱',
	Interface = '',
	Module = '',
	Property = '󰜢',
	Unit = '',
	Value = '󰎠',
	Enum = '',
	Keyword = '󰌋',
	Snippet = '',
	Color = '󰏘',
	File = '󰈙',
	Reference = '',
	Folder = '󰉋',
	EnumMember = '',
	Constant = '󰏿',
	Struct = '',
	Event = '',
	Operator = '󰆕',
	TypeParameter = '󰅲',
}
local M = {
	'hrsh7th/nvim-cmp',
	version = false,
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'rafamadriz/friendly-snippets',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'lukas-reineke/cmp-rg',
	},
}

function M.config()
	local luasnip = require('luasnip')
	local cmp = require('cmp')

	cmp.setup({
		sources = cmp.config.sources({
			{ name = 'ctags' },
			{ name = 'nvim_lsp' },
			{
				name = 'buffer',
				option = {
					get_bufnrs = function()
						local buffers = {}
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							buffers[vim.api.nvim_win_get_buf(win)] = true
						end
						return vim.tbl_keys(buffers)
					end,
				},
			},
			{ name = 'cmp-treesitter' },
			{ name = 'luasnip' },
			{ name = 'path' },
			{ name = 'rg' },
			{
				name = 'lazydev',
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			},
		}),
		snippet = {
			expand = function(args)
				-- For `luasnip` user.
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-e>'] = cmp.mapping.close(),
			['<CR>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					if luasnip.expandable() then
						luasnip.expand()
					else
						cmp.confirm({
							select = true,
						})
					end
				else
					fallback()
				end
			end),
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { 'i', 's' }),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
		}),

		formatting = {
			format = function(entry, vim_item)
				-- Kind icons
				vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
				-- Source
				vim_item.menu = ({
					buffer = '[Buffer]',
					nvim_lsp = '[LSP]',
					luasnip = '[LuaSnip]',
					nvim_lua = '[Lua]',
					latex_symbols = '[LaTeX]',
					treesitter = '[TS]',
					path = '[Path]',
					ctags = '[Tags]',
					rg = '[Grep]',
				})[entry.source.name]
				return vim_item
			end,
		},
		view = {
			entries = 'custom', -- can be "custom", "wildmenu" or "native"
		},
		performance = {
			max_view_entries = 16,
		},
	})
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return M
