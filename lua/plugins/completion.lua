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
	{
		'saghen/blink.cmp',
		--		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = {
			{ 'rafamadriz/friendly-snippets' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'lukas-reineke/cmp-rg' },
			{
				"benlubas/cmp2lsp",
				config = vim.schedule_wrap(function()
					require('cmp2lsp').setup({})
				end)
			}
		},

		-- use a release tag to download pre-built binaries
		build = 'cargo build --release',
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- On musl libc based systems you need to add this flag
		-- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',

		opts = {
			keymap = {
				show = '<c-m>',
				hide = '<c-h>',
				accept = '<Tab>',
				select_and_accept = '<cr>',
				select_prev = { '<Up>', '<C-p>' },
				select_next = { '<Down>', '<C-n>' },

				snippet_forward = '<Tab>',
				snippet_backward = '<S-Tab>',
			},
			highlight = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = true,
			},
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'normal',

			-- experimental auto-brackets support
			-- accept = { auto_brackets = { enabled = true } }

			-- experimental signature help support
			-- trigger = { signature_help = { enabled = true } }
			sources = {
				providers = {
					{ "blink.cmp.sources.lsp",    name = "LSP" },
					{ "blink.cmp.sources.path",   name = "Path",   score_offset = 3 },
					{ "blink.cmp.sources.buffer", name = "Buffer", fallback_for = { "LSP" } },
					{
						"blink.cmp.sources.snippets",
						name = 'scissor',
						opts = {
							search_paths = { vim.fn.stdpath('config') .. '/snips/json_style/' },
						},
					}
				}
			}
		},
		events = { 'InsertEnter' }
	},
	--[[ {
		"ms-jpq/coq_nvim",
		lazy = false,
		branch = "coq",
		dependencies = {
			{ "ms-jpq/coq.artifacts",   branch = "artifacts" },
			{ 'ms-jpq/coq.thirdparty',  branch = "3p" },
			{ 'mendes-davi/coq_luasnip' }
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = true,
			}
		end,
		config = function()
			vim.g.coq_settings = {
				keymap = {
					jump_to_mark = "", -- no jump_to_mark mapping
				},
				clients = {
					snippets = { enabled = false }, -- disable coq snippets
				},
			}
			require('utils.completion').coq_rg()
		end,
	}, ]]
	--[[ {
		"iguanacucumber/magazine.nvim",
		name = 'nvim-cmp',
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
		}
	}, ]]
}

-- function M.config()
local function config()
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
		---@diagnostic disable-next-line: missing-fields
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.recently_used,
				require('clangd_extensions.cmp_scores'),
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
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
