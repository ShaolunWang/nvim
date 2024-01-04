-- :fennel:1704377106
vim.opt["autoindent"] = true
vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4
vim.opt["mouse"] = ""
vim.opt["backspace"] = "indent,eol,start"
vim.opt["cursorline"] = true
vim.opt["ttyfast"] = true
vim.opt["number"] = true
vim.opt["incsearch"] = true
vim.opt["clipboard"] = "unnamedplus"
vim.opt["splitkeep"] = "screen"
vim.opt["signcolumn"] = "yes"
vim.opt["lazyredraw"] = true
vim.opt["termguicolors"] = true
vim.opt["conceallevel"] = 2
vim.g["smartindent"] = 1
vim.g["mapleader"] = " "
vim.opt["conceallevel"] = 2
vim.opt["concealcursor"] = "nc"
vim.g["maplocalleader"] = ","
vim.opt["fillchars"] =
	"horiz:\226\148\129,horizup:\226\148\187,horizdown:\226\148\179,vert:\226\148\131,vertleft:\226\148\171,vertright:\226\148\163,verthoriz:\226\149\139"
if vim.fn.executable then
	return "rg"
else
	vim.opt["grepprg"] = "rg --no-heading --vimgrep --smart-case --hidden --glob=!.git/"
	if nil then
		vim.opt["grepformat"] = "%f:%l:%c:%m"
		return nil
	else
		return nil
	end
end
