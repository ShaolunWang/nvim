(local kind-icons {:Class "󰠱"
                   :Color "󰏘"
                   :Constant "󰏿"
                   :Constructor ""
                   :Enum ""
                   :EnumMember ""
                   :Event ""
                   :Field "󰇽"
                   :File "󰈙"
                   :Folder "󰉋"
                   :Function "󰊕"
                   :Interface ""
                   :Keyword "󰌋"
                   :Method "󰆧"
                   :Module ""
                   :Operator "󰆕"
                   :Property "󰜢"
                   :Reference ""
                   :Snippet ""
                   :Struct ""
                   :Text ""
                   :TypeParameter "󰅲"
                   :Unit ""
                   :Value "󰎠"
                   :Variable "󰂡"})

(local M {1 :hrsh7th/nvim-cmp
          :dependencies [:hrsh7th/cmp-nvim-lsp
                         :hrsh7th/cmp-buffer
                         :hrsh7th/cmp-path
                         :hrsh7th/cmp-cmdline
                         :rafamadriz/friendly-snippets
                         :L3MON4D3/LuaSnip
                         :saadparwaiz1/cmp_luasnip
                         :delphinus/cmp-ctags]
          :event :InsertEnter
          :version false})

(fn has-words-before []
  (when (= (vim.api.nvim_buf_get_option 0 :buftype) :prompt)
    (lua "return false"))
  (local (line col) (unpack (vim.api.nvim_win_get_cursor 0)))
  (and (not= col 0) (= (: (: (. (vim.api.nvim_buf_get_lines 0 (- line 1) line
                                                            true)
                                1) :sub col col)
                          :match "%s") nil)))

(fn M.config []
  (let [luasnip (require :luasnip)
        cmp (require :cmp)]
    (fn tab-mapping [fallback]
      (if (cmp.visible) (cmp.select_next_item)
          (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
          (has-words-before) (cmp.complete)
          (fallback)))

    (fn reverse-tab-mapping [fallback]
      (if (cmp.visible) (cmp.select_prev_item)
          (luasnip.jumpable (- 1)) (luasnip.jump (- 1))
          (fallback)))

    (cmp.setup {:formatting {:format (fn [entry vim-item]
                                       (set vim-item.kind
                                            (string.format "%s %s"
                                                           (. kind-icons
                                                              vim-item.kind)
                                                           vim-item.kind))
                                       (set vim-item.menu
                                            (. {:buffer "[Buffer]"
                                                :ctags "[Tags]"
                                                :latex_symbols "[LaTeX]"
                                                :luasnip "[LuaSnip]"
                                                :nvim_lsp "[LSP]"
                                                :nvim_lua "[Lua]"}
                                               entry.source.name))
                                       vim-item)}
                :mapping (cmp.mapping.preset.insert {:<C-d> (cmp.mapping.scroll_docs (- 4))
                                                     :<C-e> (cmp.mapping.close)
                                                     :<C-f> (cmp.mapping.scroll_docs 4)
                                                     :<CR> (cmp.mapping.confirm {:select true})
                                                     :<S-Tab> (cmp.mapping reverse-tab-mapping
                                                                           [:i
                                                                            :s])
                                                     :<Tab> (cmp.mapping tab-mapping
                                                                         [:i
                                                                          :s])})
                :performance {:max_view_entries 16}
                :snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
                :sources (cmp.config.sources [{:name :ctags}
                                              {:name :nvim_lsp}
                                              {:name :buffer
                                               :option {:get_bufnrs (fn []
                                                                      (local buffers
                                                                             {})
                                                                      (each [_ win (ipairs (vim.api.nvim_list_wins))]
                                                                        (tset buffers
                                                                              (vim.api.nvim_win_get_buf win)
                                                                              true))
                                                                      (vim.tbl_keys buffers))}}
                                              {:name :luasnip}
                                              {:name :path}])
                :view {:entries :custom}})
    (cmp.setup.cmdline "/"
                       {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :buffer}]})
    (cmp.setup.cmdline ":"
                       {:mapping (cmp.mapping.preset.cmdline)
                        :sources (cmp.config.sources [{:name :path}]
                                                     [{:name :cmdline
                                                       :option {:ignore_cmds [:Man
                                                                              "!"
                                                                              :w
                                                                              :q]}}])})
    (cmp.setup.cmdline "@" {:enabled false})
    (cmp.setup.cmdline ">" {:enabled false})
    (cmp.setup.cmdline "-" {:enabled false})
    (cmp.setup.cmdline "=" {:enabled false})
    (local cmp-autopairs (require :nvim-autopairs.completion.cmp))
    (cmp.event:on :confirm_done (cmp-autopairs.on_confirm_done))))

M
