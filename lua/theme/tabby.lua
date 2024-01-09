-- :fennel:1704702217
local theme = {current_tab = "TabLineSel", fill = "TabLineFill", head = "TabLine", tab = "TabLine", tail = "TabLine", win = "TabLine"}
local function _1_(line)
  local function _2_(tab)
    local hl = ("TabLineSel" or theme.tab)
    return {line.sep("\238\130\186", hl, "TablineFill"), ((tab.is_current() and "\239\134\146") or "\243\176\134\163"), tab.number(), tab.name(), tab.close_btn("\239\128\141"), line.sep("\238\130\188", hl, "TablineFill"), hl = hl, margin = " "}
  end
  local function _3_(win)
    return {line.sep("\238\130\186", "TabLineSel", "TablineFill"), ((win.is_current() and "\239\134\146") or "\239\132\140"), win.buf_name(), line.sep("\238\130\188", "TabLineSel", "TablineFill"), hl = "TabLineSel", margin = " "}
  end
  return {line.tabs().foreach(_2_), line.spacer(), line.wins_in_tab(line.api.get_current_tab()).foreach(_3_), {{" \239\131\182 ", hl = "TablLineFill"}}, hl = "TablineFill"}
end
return require("tabby.tabline").set(_1_)