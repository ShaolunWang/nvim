(local lazy (require :lazy))
(local plugins
	[
		{1 :windwp/nvim-autopairs}
     	{1 :hrsh7th/nvim-cmp
			:dependencies 
			[
				:hrsh7th/cmp-nvim-lsp
				:L3MON4D3/LuaSnip
				:saadparwaiz1/cmp_luasnip
			]
		}
		{1 :nvim-treesitter/nvim-treesitter 
		   :opts {:highlight {:enable true}}
		   :event "BufReadPre"
		}
		{1 
		:stevearc/oil.nvim
		:opts  {
		{:use_default_keymaps false}
			{:keymaps {
				"<CR>" :actions.select
				"-"    :actions.parent
				"_"    :actions.open_cwd
				"`"    :actions.cd
				"~"    :actions.tcd
				"g."   :actions.toggle_hidden
				"g?"   false
				"<C-s>"  false
				"<C-h>"  false
				"<C-t>"  false
				"<C-p>"  false
				"<C-c>"  false
				"<C-l>"  false
				"gs" false
				"gx" false
				"g\\" false
			}}
		}
		; Optional dependencies
		:dependencies "nvim-tree/nvim-web-devicons"
		;   keys = {"<C-n>"}
		:cmd "Oil"}

	]
)
(lazy.setup plugins {
  :performance {
    :reset_packpath false
  }
})
