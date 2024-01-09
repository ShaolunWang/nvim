-- :fennel:1704703658
local function _1_()
  vim.opt.sessionoptions = {"buffers", "tabpages", "globals"}
  require("scope").setup({})
  return require("tabby").setup({})
end
return {{"fynnfluegge/monet.nvim"}, {"projekt0n/github-nvim-theme"}, {"nanozuki/tabby.nvim", config = _1_, dependencies = {"tiagovla/scope.nvim"}, event = "VeryLazy"}, {"rebelot/heirline.nvim", event = "VeryLazy"}, {"fynnfluegge/monet.nvim"}}