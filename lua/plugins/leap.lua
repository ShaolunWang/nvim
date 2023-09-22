return {
  'ggandor/leap.nvim',
  config = function()
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    require('leap').setup({
      case_sensitive = true,
    })
  end,
  keys = {"g", "s", "S", "<C-s>"},
}
