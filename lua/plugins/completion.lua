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
		-- optional: provides snippets for the snippet source
		lazy = false,
		dependencies = {
			{ 'rafamadriz/friendly-snippets' },
			{ 'saadparwaiz1/cmp_luasnip' },
			-- { 'lukas-reineke/cmp-rg' },
			--
			{
				'saghen/blink.compat',
				opts = {
					-- lazydev.nvim only registers the completion source when nvim-cmp is
					-- loaded, so pretend that we are nvim-cmp, and that nvim-cmp is loaded.
					-- this option only has effect when using lazy.nvim
					-- this should not be required in most cases
					impersontate_nvim_cmp = true,
				},
			},
		},

		-- use a release tag to download pre-built binaries
		--	build = 'cargo build --release',
		version = '*',
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- On musl libc based systems you need to add this flag
		-- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',

		opts = {
			window = { autocomplete = { selection = 'manual' } },
			keymap = {
				['<c-m>'] = { 'show' },
				['<c-h>'] = { 'hide' },
				['<Tab>'] = { 'select_and_accept', 'fallback' },
				['<cr>'] = { 'select_and_accept', 'fallback' },
				['<C-p>'] = { 'select_prev' },
				['<C-n>'] = { 'select_next' },
				['<c-d>'] = { 'snippet_forward' },
				['<c-u>'] = { 'snippet_backward ' },
			},

			snippets = {
				expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
				active = function(filter)
					if filter and filter.direction then
						return require('luasnip').jumpable(filter.direction)
					end
					return require('luasnip').in_snippet()
				end,
				jump = function(direction) require('luasnip').jump(direction) end,
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
				completion = {
					enabled_providers = {
						'lsp',
						'path',
						'snippets',
						--[[ 'buffer', 'rg', 'luasnip' ]]
					},
				},
				providers = {
					lsp = { module = 'blink.cmp.sources.lsp', name = 'LSP', enabled = true, score_offset = -1 },
					path = {
						name = 'Path',
						module = 'blink.cmp.sources.path',
						score_offset = 0,
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
							end,
							show_hidden_files_by_default = false,
						},
					},
					buffer = { module = 'blink.cmp.sources.buffer', name = 'Buffer', enabled = true, fallback_for = { 'LSP' } },
					luasnip = {
						name = 'luasnip',
						module = 'blink.compat.source',

						score_offset = -3,

						opts = {
							use_show_condition = false,
							show_autosnippets = true,
						},
					},
					rg = {
						module = 'blink.compat.source',
						name = 'rg',
						enabled = true,
						score_offset = -3,
						fallback_for = { 'Buffer' },
						transform_items = function(ctx, items)
							-- TODO: check https://github.com/Saghen/blink.cmp/pull/253#issuecomment-2454984622
							local kind = require('blink.cmp.types').CompletionItemKind.Text

							for i = 1, #items do
								items[i].kind = kind
							end

							return items
						end,
					},
				},
			},
		},
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
