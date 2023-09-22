return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufReadPre" },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        map_cr = false,
        check_ts = true,
      })
    end,
  },
  { 
    "numToStr/Comment.nvim", 
    keys = {'gc'},
  },
  {
    'tpope/vim-unimpaired',
    keys = { '[', ']' },
  },
  {
    "tversteeg/registers.nvim",
    config = function()
      require("registers").setup({ bind_keys = { normal = false, insert = false } })
    end,
    keys = {
      { "\"", mode = { "n", "v" } },
    },
    cmd = "Registers",
  }, 
}
