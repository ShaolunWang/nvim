(local M {})
(local opts {:noremap true :silent true})
(vim.keymap.set :n "[d" vim.diagnostic.goto_prev opts)
(vim.keymap.set :n "]d" vim.diagnostic.goto_next opts)
(fn opt-desc [opt description] (set table.desc description) opt)
(fn M.on_attach [_ bufnr]
  (vim.api.nvim_buf_set_option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
  (local bufopts {:buffer bufnr :noremap true :silent true})
  (vim.keymap.set :n :K vim.lsp.buf.hover (opt-desc bufopts :hover))
  (vim.keymap.set :n "\\D" vim.lsp.buf.type_definition
                  (opt-desc bufopts "Jumps to type def"))
  (vim.keymap.set :n "\\r" vim.lsp.buf.rename
                  (opt-desc bufopts "Rename Variable"))
  (vim.keymap.set :n "\\a" vim.lsp.buf.code_action
                  (opt-desc bufopts "Code Action"))
  (vim.keymap.set :n "\\q" vim.diagnostic.setloclist
                  (opt-desc opts "Diag Loclist"))
  (vim.keymap.set :n "\\f" (fn [] (vim.lsp.buf.format {:async true}))
                  (opt-desc bufopts "format code"))
  (vim.keymap.set :n :gD vim.lsp.buf.declaration (opt-desc bufopts "Goto Decl"))
  (vim.keymap.set :n :gd vim.lsp.buf.definition (opt-desc bufopts "Goto Def"))
  (vim.keymap.set :n :gi vim.lsp.buf.implementation
                  (opt-desc bufopts "Show Impl"))
  (vim.keymap.set :n :gK vim.diagnostic.open_float
                  (opt-desc bufopts "Line Diag"))
  (vim.keymap.set :n :gr vim.lsp.buf.references
                  (opt-desc bufopts "Show References")))
M	
