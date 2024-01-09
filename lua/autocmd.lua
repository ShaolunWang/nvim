-- :fennel:1704795426
vim.api.nvim_create_augroup("yank_highlight", {})
local function _1_()
  local mark = vim.api.nvim_buf_get_mark(0, "\"")
  local lcount = vim.api.nvim_buf_line_count(0)
  if ((mark[1] > 0) and (mark[1] <= lcount)) then
    return pcall(vim.api.nvim_win_set_cursor, 0, mark)
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("BufReadPost", {callback = _1_})
local function _3_()
  local fidget = require("fidget")
  fidget.notify("yanking")
  return vim.highlight.on_yank({higroup = "IncSearch", timeout = 400})
end
vim.api.nvim_create_autocmd("TextYankPost", {callback = _3_, group = "yank_highlight", pattern = "*"})
local function _4_()
  vim.api.nvim_buf_set_keymap(0, "n", "<,o>", "<cmd>colder<CR>", {noremap = true, silent = true})
  return vim.api.nvim_buf_set_keymap(0, "n", "<,i>", "<cmd>cnewer<CR>", {noremap = true, silent = true})
end
vim.api.nvim_create_autocmd("FileType", {callback = _4_, pattern = "qf"})
local llvm_highlight = vim.api.nvim_create_augroup("llvm-highlight", {})
local function _5_()
  return vim.cmd("set ft=mlir")
end
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {callback = _5_, group = llvm_highlight, pattern = {"*.mlir", "*.xdsl"}})
vim.cmd("au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif")
local function _6_()
  return vim.cmd("set ft=tablegen")
end
vim.api.nvim_create_autocmd("FileType", {callback = _6_, group = llvm_highlight, pattern = {"*.td"}})
return vim.api.nvim_clear_autocmds({event = "BufLeave", group = "Grapple"})
