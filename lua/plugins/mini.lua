-- :fennel:1704874869
local function _1_()
  local miniclue = require("mini.clue")
  return miniclue.setup({clues = {{desc = "+Fuzzy Search...", keys = "<Leader>f", mode = "n"}, {desc = "+Tab ...", keys = "<Leader>t", mode = "n"}, {desc = "+Grapple ...", keys = "<Leader>g", mode = "n"}, {desc = "+Lsp ...", keys = "\\", mode = "n"}, {desc = "+g ...", keys = "g", mode = "n"}, {desc = "+unimpaired ...", keys = ",", mode = "n"}, {desc = "+unimpaired ...", keys = "[", mode = "n"}, {desc = "+unimpaired ...", keys = "]", mode = "n"}, miniclue.gen_clues.windows({submode_resize = true})}, triggers = {{keys = "g", mode = "n"}, {keys = "<Leader>", mode = "n"}, {keys = "\\", mode = "n"}, {keys = ",", mode = "n"}, {keys = "[", mode = "n"}, {keys = "]", mode = "n"}, {keys = "<C-w>", mode = "n"}}, window = {config = {anchor = "SW", col = "auto", row = "auto", width = "auto"}, delay = 500}})
end
local function _2_()
  local hipatterns = require("mini.hipatterns")
  return hipatterns.setup({highlighters = {deprecated = {group = "MiniHipatternsFixme", pattern = "%f[%w]()DEPRECATE()%f[%W]"}, fixme = {group = "MiniHipatternsFixme", pattern = "%f[%w]()FIXME()%f[%W]"}, hack = {group = "Deprecation", pattern = "%f[%w]()HACK()%f[%W]"}, hex_color = hipatterns.gen_highlighter.hex_color(), note = {group = "MiniHipatternsNote", pattern = "%f[%w]()NOTE()%f[%W]"}, todo = {group = "MiniHipatternsTodo", pattern = "%f[%w]()TODO()%f[%W]"}}})
end
local function _3_()
  local miniscope = require("mini.indentscope")
  return miniscope.setup({draw = {animation = miniscope.gen_animation.none(), delay = 0}})
end
return {{"echasnovski/mini.clue", config = _1_, keys = {"<leader>", "\\", "g", ",", "[", "]", "<c-w>"}}, {"echasnovski/mini.hipatterns", config = _2_, version = false}, {"echasnovski/mini.move", keys = {"[", "]", "<e", ">e"}, opts = {mappings = {down = "]e", left = "<e", line_down = "]e", line_left = "<e", line_right = ">e", line_up = "[e", right = ">e", up = "[e"}, options = {reindent_linewise = true}}, version = false}, {"echasnovski/mini.indentscope", config = _3_, version = false}}