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
		'hrsh7th/cmp-cmdline',
		'rafamadriz/friendly-snippets',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'delphinus/cmp-ctags',
	},
}

local function has_words_before()
	if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

function M.config()
	local luasnip = require('luasnip')
	local cmp = require('cmp')

	local function tab_mapping(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
		end
	end

	local function reverse_tab_mapping(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end

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
			{ name = 'luasnip' },
			{ name = 'path' },
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
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<Tab>'] = cmp.mapping(tab_mapping, { 'i', 's' }),
			['<S-Tab>'] = cmp.mapping(reverse_tab_mapping, { 'i', 's' }),
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
					ctags = '[Tags]',
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
	-- `/` cmdline setup.
	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' },
		},
	})
	-- `:` cmdline setup.
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' },
		}, {
			{
				name = 'cmdline',
				option = {
					ignore_cmds = { 'Man', '!', 'w', 'q' },
				},
			},
		}),
	})
	cmp.setup.cmdline('@', { enabled = false })
	cmp.setup.cmdline('>', { enabled = false })
	cmp.setup.cmdline('-', { enabled = false })
	cmp.setup.cmdline('=', { enabled = false })
	-- We need to setup cmp first hence this being after cmp.setup()
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return M
