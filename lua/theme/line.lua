-- :fennel:1704876106
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local M = {}
local Align = {provider = "%="}
local Separator = {provider = "\238\130\177 "}
local Space = {provider = " "}
require("heirline").load_colors({blue = "#005078", cyan = "#007676", green = "#015825", grey1 = "#0a0b10", grey2 = "#1c1d23", grey3 = "#2c2e33", grey4 = "#4f5258", magenta = "#4c0049", red = "#5e0009", yellow = "#6e5600"})
local Vi_mode = nil
local function _2f_1_(self)
  local mode = (self.mode):sub(1, 1)
  return {bold = true, fg = self.mode_colors[mode]}
end
local function _2f_2_(self)
  self.mode = vim.fn.mode(1)
  if not self.once then
    vim.api.nvim_create_autocmd("ModeChanged", {command = "redrawstatus"})
    self.once = true
    return nil
  else
    return nil
  end
end
local function _2f_4_(self)
  return ("%2(" .. self.mode_names[self.mode] .. "%)")
end
Vi_mode = {hl = _2f_1_, init = _2f_2_, provider = _2f_4_, static = {mode_colors = {["\19"] = "purple", ["\22"] = "cyan", ["!"] = "red", R = "orange", S = "purple", V = "cyan", c = "orange", i = "green", n = "green", r = "orange", s = "purple", t = "red", v = "cyan"}, mode_names = {["\19"] = "^S", ["\22"] = "^V", ["\22s"] = "^V", ["!"] = "!", R = "R", Rc = "Rc", Rv = "Rv", Rvc = "Rv", Rvx = "Rv", Rx = "Rx", S = "S_", V = "V_", Vs = "Vs", c = "C", cv = "Ex", i = "I", ic = "Ic", ix = "Ix", n = "N", niI = "Ni", niR = "Nr", niV = "Nv", no = "N?", ["no\22"] = "N?", noV = "N?", nov = "N?", nt = "Nt", r = "...", ["r?"] = "?", rm = "M", s = "S", t = "T", v = "V", vs = "Vs"}}, update = "ModeChanged"}
local File_name = nil
local function _2f_5_(self)
  local filename = vim.fn.fnamemodify(self.filename, ":.")
  if (filename == "") then
    return "[No Name]"
  else
  end
  if not conditions.width_percent_below(#filename, 0.25) then
    filename = vim.fn.pathshorten(filename)
  else
  end
  return filename
end
File_name = {hl = {fg = utils.get_highlight("Directory").fg}, provider = _2f_5_}
local Help_file_name = nil
local function _2f_8_()
  return (vim.bo.filetype == "help")
end
local function _2f_9_()
  local filename = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnamemodify(filename, ":t")
end
Help_file_name = {condition = _2f_8_, hl = {fg = "blue"}, provider = _2f_9_}
local File_flags = nil
local function _2f_10_()
  return vim.bo.modified
end
local function _2f_11_()
  return (not vim.bo.modifiable or vim.bo.readonly)
end
File_flags = {{condition = _2f_10_, hl = {fg = "green"}, provider = "[+]"}, {condition = _2f_11_, hl = {fg = "orange"}, provider = "\239\128\163"}}
local Work_dir = nil
local function _2f_12_()
  local cwd = vim.fn.expand("%")
  cwd = vim.fn.fnamemodify(cwd, ":~")
  return cwd
end
Work_dir = {hl = {fg = utils.get_highlight("Directory").bg}, provider = _2f_12_}
local Default_statusline = {Vi_mode, Space, Separator, File_flags, Space, Work_dir, Space}
local Inactive_statusline = nil
local function _2f_13_()
  return not conditions.is_active()
end
Inactive_statusline = {Separator, File_name, Align, condition = _2f_13_}
local Terminal_name = nil
local function _2f_14_()
  local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
  return ("\239\146\137 " .. tname)
end
Terminal_name = {hl = {bold = true, fg = "blue"}, provider = _2f_14_}
local Terminal_statusline = nil
local function _2f_15_()
  return conditions.buffer_matches({buftype = {"terminal"}})
end
Terminal_statusline = {{Vi_mode, Separator, condition = conditions.is_active}, Terminal_name, Align, condition = _2f_15_}
local Special_statusline = nil
local function _2f_16_()
  return conditions.buffer_matches({buftype = {"nofile", "prompt", "help", "quickfix"}, filetype = {"^git.*", "fugitive"}})
end
Special_statusline = {Separator, Help_file_name, Align, condition = _2f_16_}
local Status_lines = {Special_statusline, Terminal_statusline, Inactive_statusline, Default_statusline, fallthrough = false}
require("heirline").setup({statusline = Status_lines})
return M