-- :fennel:1704876891
local kind_icons = {Class = "\243\176\160\177", Color = "\243\176\143\152", Constant = "\243\176\143\191", Constructor = "\239\144\163", Enum = "\239\133\157", EnumMember = "\239\133\157", Event = "\239\131\167", Field = "\243\176\135\189", File = "\243\176\136\153", Folder = "\243\176\137\139", Function = "\243\176\138\149", Interface = "\239\131\168", Keyword = "\243\176\140\139", Method = "\243\176\134\167", Module = "\239\146\135", Operator = "\243\176\134\149", Property = "\243\176\156\162", Reference = "\239\146\129", Snippet = "\239\145\143", Struct = "\239\134\179", Text = "\238\152\146", TypeParameter = "\243\176\133\178", Unit = "\238\136\159", Value = "\243\176\142\160", Variable = "\243\176\130\161"}
local M = {"hrsh7th/nvim-cmp", dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "delphinus/cmp-ctags"}, event = "InsertEnter", version = false}
local function has_words_before()
  if (vim.api.nvim_buf_get_option(0, "buftype") == "prompt") then
    return false
  else
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return ((col ~= 0) and ((vim.api.nvim_buf_get_lines(0, (line - 1), line, true)[1]):sub(col, col):match("%s") == nil))
end
M.config = function()
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  local function tab_mapping(fallback)
    if cmp.visible() then
      return cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      return luasnip.expand_or_jump()
    elseif has_words_before() then
      return cmp.complete()
    else
      return fallback()
    end
  end
  local function reverse_tab_mapping(fallback)
    if cmp.visible() then
      return cmp.select_prev_item()
    elseif luasnip.jumpable(( - 1)) then
      return luasnip.jump(( - 1))
    else
      return fallback()
    end
  end
  local function _4_(entry, vim_item)
    vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
    vim_item.menu = ({buffer = "[Buffer]", ctags = "[Tags]", latex_symbols = "[LaTeX]", luasnip = "[LuaSnip]", nvim_lsp = "[LSP]", nvim_lua = "[Lua]"})[entry.source.name]
    return vim_item
  end
  local function _5_(args)
    return luasnip.lsp_expand(args.body)
  end
  local function _6_()
    local buffers = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      buffers[vim.api.nvim_win_get_buf(win)] = true
    end
    return vim.tbl_keys(buffers)
  end
  cmp.setup({formatting = {format = _4_}, mapping = cmp.mapping.preset.insert({["<C-d>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-e>"] = cmp.mapping.close(), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<CR>"] = cmp.mapping.confirm({select = true}), ["<S-Tab>"] = cmp.mapping(reverse_tab_mapping, {"i", "s"}), ["<Tab>"] = cmp.mapping(tab_mapping, {"i", "s"})}), performance = {max_view_entries = 16}, snippet = {expand = _5_}, sources = cmp.config.sources({{name = "ctags"}, {name = "nvim_lsp"}, {name = "buffer", option = {get_bufnrs = _6_}}, {name = "luasnip"}, {name = "path"}}), view = {entries = "custom"}})
  cmp.setup.cmdline("/", {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})
  cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline", option = {ignore_cmds = {"Man", "!", "w", "q"}}}})})
  cmp.setup.cmdline("@", {enabled = false})
  cmp.setup.cmdline(">", {enabled = false})
  cmp.setup.cmdline("-", {enabled = false})
  cmp.setup.cmdline("=", {enabled = false})
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  return (cmp.event):on("confirm_done", cmp_autopairs.on_confirm_done())
end
return M