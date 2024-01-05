(local M {})
(local border [["🭽" :FloatBorder]
               ["▔" :FloatBorder]
               ["🭾" :FloatBorder]
               ["▕" :FloatBorder]
               ["🭿" :FloatBorder]
               ["▁" :FloatBorder]
               ["🭼" :FloatBorder]
               ["▏" :FloatBorder]])
(local orig-util-open-floating-preview vim.lsp.util.open_floating_preview)
(fn vim.lsp.util.open_floating_preview [contents syntax opts ...]
  (set-forcibly! opts (or opts {}))
  (set opts.border (or opts.border border))
  (orig-util-open-floating-preview contents syntax opts ...))
(local (has-cmp cmp-nvim-lsp) (pcall require :cmp_nvim_lsp))
(set M.c
     (vim.tbl_deep_extend :force {} (vim.lsp.protocol.make_client_capabilities)
                          (or (and has-cmp (cmp-nvim-lsp.default_capabilities))
                              {}) {}
                          {:textDocument {:foldingRange {:dynamicRegistration false
                                                         :lineFoldingOnly true}}}))
(fn M.goto_definition [split-cmd]
  (let [util vim.lsp.util
        log (require :vim.lsp.log)
        api vim.api]
    (fn handler [_ result ctx]
      (when (or (= result nil) (vim.tbl_isempty result))
        (local _ (and (log.info) (log.info ctx.method "No location found")))
        (lua "return nil"))
      (when split-cmd (vim.cmd split-cmd))
      (if (vim.tbl_islist result)
          (do
            (util.jump_to_location (. result 1))
            (when (> (length result) 1)
              (util.set_qflist (util.locations_to_items result))
              (api.nvim_command :copen)
              (api.nvim_command "wincmd p")))
          (util.jump_to_location result)))

    handler))
(set M.lsp_handlers
     {:textDocument/definition (M.goto_definition :split)
      :textDocument/hover (vim.lsp.with vim.lsp.handlers.hover {: border})
      :textDocument/signatureHelp (vim.lsp.with vim.lsp.handlers.signature_help
                                    {: border})})
(set M.c.textDocument.completion.completionItem.snippetSupport true)
(set M.c.textDocument.completion.completionItem.resolveSupport
     {:properties [:documentation :detail :additionalTextEdits]})
M	
