-- :fennel:1704376634
require("config")
require("plugins")
if vim.loader then
	vim.loader.enable()
else
end
vim.g["loader_luv"] = true
return nil
