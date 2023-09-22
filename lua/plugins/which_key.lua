return {
  'folke/which-key.nvim',
  config = function()
    require('which-key').setup({
      triggers = { "<space>", "g", "\\", "z", "," },
      key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
      },
    })
  end,
  lazy = true,
}
