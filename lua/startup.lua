-- :fennel:1704466032
require("config")
require("plug")
require("theme")
require("keymap")
require("autocmd")
if vim.loader then
  vim.loader.enable()
else
end
vim.g["loader_luv"] = true
return nil