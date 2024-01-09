-- :fennel:1704702217
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
vim.opt["fillchars"] = "horiz:\226\148\129,horizup:\226\148\187,horizdown:\226\148\179,vert:\226\148\131,vertleft:\226\148\171,vertright:\226\148\163,verthoriz:\226\149\139"
vim.diagnostic.config({severity_sort = true, signs = true, underline = true, update_in_insert = true, virtual_text = true})
local signs = {Error = "! ", Hint = "\238\172\147 ", Info = "\239\145\137 ", Warn = "\239\148\169 "}
for type, icon in pairs(signs) do
  local hl = ("DiagnosticSign" .. type)
  vim.fn.sign_define(hl, {numhl = hl, text = icon, texthl = hl})
end
if (vim.fn.executable("rg") == 1) then
  vim.opt.grepprg = "rg --no-heading --vimgrep --smart-case --hidden --glob=!.git/"
  vim.opt.grepformat = "%f:%l:%c:%m"
else
end
vim.cmd("  command! -bang -nargs=* -complete=file_in_path -bar Grep call asyncdo#run(\n              \\ <bang>0,\n              \\ { 'job': &grepprg, 'errorformat': &grepformat },\n              \\ <f-args>) \n  command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)\n\n  noreabbrev  <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent Grep'  : 'grep'\n  cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'\n  augroup init_quickfix\n    autocmd!\n    autocmd QuickFixCmdPost [^l]* cwindow\n    autocmd QuickFixCmdPost l* lwindow\n  augroup END\n")
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
