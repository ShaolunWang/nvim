-- :fennel:1704791616
local function _1_(_, opts)
  return require("nvim-treesitter.configs").setup(opts)
end
return {"nvim-treesitter/nvim-treesitter", config = _1_, event = {"BufReadPre"}, opts = {ensure_installed = {"c", "cpp", "lua", "python", "vim", "rust"}, highlight = {enable = true}}}
