vim.o.termguicolors = true
vim.o.background = ""
require("theme.line")
require 'kanagawa'.setup(
  {
    overrides = function(colors)
      return {
        WinSeparator = {
          fg = colors.palette.oldWhite,
          bg = "NONE"
        }
      }
    end
  })
require("kanagawa").load()
vim.g['showtabline'] = 2
