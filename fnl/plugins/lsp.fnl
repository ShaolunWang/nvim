{1 :neovim/nvim-lspconfig
 :config (fn []
           (local utils (require :utils.lsp))
           (set vim.o.updatetime 1)
           (vim.cmd "      highlight DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
      highlight DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
      highlight DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
      highlight DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

      sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
      sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
      sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
      sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
    ")
           (local lsp (require :lspconfig))
           (local lsp-keymap (require :keymap.lsp_keymaps))
           (lsp.pyright.setup {:handlers utils.lsp_handlers
                               :on_attach lsp-keymap.on_attach})
           (lsp.ruff_lsp.setup {:handlers utils.lsp_handlers
                                :on_attach lsp-keymap.on_attach})
           (lsp.ocamllsp.setup {:handlers utils.lsp_handlers
                                :on_attach lsp-keymap.on_attach})
           (local clang-handlers utils.lsp_handlers)
           (local no-diagnostic {:textDocument/publishDiagnostics (fn [])})
           (each [k v (pairs no-diagnostic)] (tset clang-handlers k v))
           (lsp.clangd.setup {:handlers utils.lsp_handlers
                              :on_attach (fn [client bufnr]
                                           ((. (require :clangd_extensions.inlay_hints)
                                               :setup_autocmd))
                                           ((. (require :clangd_extensions.inlay_hints)
                                               :set_inlay_hints))
                                           (lsp-keymap.on_attach client bufnr))}))
 :ft [:python :ocaml :cpp :ts]}
