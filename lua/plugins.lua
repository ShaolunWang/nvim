-- :fennel:1704383837
local lazy = require("lazy")
local plugins = {
	{ "windwp/nvim-autopairs" },
	{ "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" } },
	{ "nvim-treesitter/nvim-treesitter", opts = { highlight = { enable = true } }, event = "BufReadPre" },
	{
		"stevearc/oil.nvim",
		opts = {
			[{ use_default_keymaps = false }] = {
				keymaps = {
					["<CR>"] = "actions.select",
					["-"] = "actions.parent",
					_ = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["g."] = "actions.toggle_hidden",
					["g?"] = "false",
					["<C-c>"] = false,
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-p>"] = false,
					["<C-s>"] = false,
					["<C-t>"] = false,
					["g\\"] = false,
					gs = false,
					gx = false,
				},
			},
		},
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = "Oil",
	},
}
return lazy.setup(plugins, { performance = { reset_packpath = false } })
