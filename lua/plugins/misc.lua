return {
	{
		'numToStr/Comment.nvim',
		opts = function()
			local commentstring_avail, commentstring = pcall(require,
				'ts_context_commentstring.integrations.comment_nvim')
			return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
		end,
		config = function()
			require('Comment').setup()
		end,
		keys = {
			{ 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
			{ 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
		},
	},
	{
		'tversteeg/registers.nvim',
		config = function()
			require('registers').setup({ bind_keys = { normal = false, insert = false } })
		end,
		keys = {
			{ '"', mode = { 'n', 'v' } },
		},
		cmd = 'Registers',
	},
	{
		'kevinhwang91/nvim-bqf',
		opts = {
			preview = {
				win_height = 999,
				win_vheight = 999,
			},
			func_enable = {
				drop = 'd',
				openc = 'o',
				split = '<C-v>',
				tabdrop = '<C-t>',
				tabc = '',
				ptogglemode = 'z,',
			},
		},
		ft = { 'qf' },
	},
	{
		'j-hui/fidget.nvim',
		config = function()
			require('fidget').setup({
				notification = {
					override_vim_notify = true,
					configs = {
						default = {
							name = '',
							icon = '',
							ttl = 5,
							group_style = 'Title',
							icon_style = 'Special',
							annote_style = 'Question',
							debug_style = 'Comment',
							warn_style = 'WarningMsg',
							error_style = 'ErrorMsg',
							debug_annote = 'DEBUG',
							info_annote = 'INFO',
							warn_annote = 'WARN',
							error_annote = 'ERROR',
						},
					},
					window = {
						border = 'rounded',
						normal_hl = '',
					},
				},
				integration = {
					['nvim-tree'] = {
						enable = false, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
					},
				},
			})
		end,
		event = 'BufReadPost',
	},
	{
		'hauleth/asyncdo.vim',
	},
	{ 'chrisbra/NrrwRgn' },
	{
		'SmiteshP/nvim-navic',
		dependencies = { 'neovim/nvim-lspconfig' },
		lazy = true,
	},

	{
		'lukas-reineke/indent-blankline.nvim',
		opts = {
			indent = {
				char = '│',
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
				char = '│',
				--	highlight = 'IndentBlanklineContextChar',
			},
			exclude = {
				filetypes = {
					'NvimTree',
					'qf',
					'terminal',
					'fzf',
				},
			},
		},
		main = 'ibl',
		event = { 'BufReadPost' },
	},
	{
		'NeogitOrg/neogit',
		branch = 'nightly',
		cmd = 'Neogit',
		dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'ibhagwan/fzf-lua' },
		opts = {
			auto_refresh = true,
			integrations = { diffview = true },
			kind = 'tab',
			use_magit_keybindings = true,
			disable_builtin_notifications = false,
		},
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "? ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		},
		event = "BufReadPost",
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>e",
				function()
					require("edgy").toggle()
					require('fidget').notify("edgy toggle")
				end,
				desc = "Edgy Toggle",
			},
			-- stylua: ignore
			{ "<leader>s", function() require("edgy").select() end, desc = "Edgy Select Window" },
		},
		opts = function()
			local opts = {
				bottom = {

					"Trouble",
					{ ft = "qf", title = "QuickFix" },
					{
						ft = "help",
						size = { height = 20 },
						-- don't open help files in edgy that we're editing
						filter = function(buf)
							return vim.bo[buf].buftype == "help"
						end,
					},
				},
				left = {
				},
				keys = {
					-- increase width
					["<c-Right>"] = function(win)
						win:resize("width", 2)
					end,
					-- decrease width
					["<c-Left>"] = function(win)
						win:resize("width", -2)
					end,
					-- increase height
					["<c-Up>"] = function(win)
						win:resize("height", 2)
					end,
					-- decrease height
					["<c-Down>"] = function(win)
						win:resize("height", -2)
					end,
				},
			}
			for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
				opts[pos] = opts[pos] or {}
				table.insert(opts[pos], {
					ft = "trouble",
					filter = function(_buf, win)
						return vim.w[win].trouble
							and vim.w[win].trouble.position == pos
							and vim.w[win].trouble.type == "split"
							and vim.w[win].trouble.relative == "editor"
							and not vim.w[win].trouble_preview
					end,
				})
			end
			return opts
		end,
	}
}
