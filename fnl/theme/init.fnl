(set vim.g.showtabline 3)
(set vim.g.termguicolors true)
(vim.cmd "colorscheme kanagawa")
(vim.api.nvim_set_hl 0 :CmpItemAbbrDeprecated
                     {:bg :NONE :fg "#808080" :strikethrough true})
(vim.api.nvim_set_hl 0 :CmpItemAbbrMatch {:bg :NONE :fg "#569CD6"})
(vim.api.nvim_set_hl 0 :CmpItemAbbrMatchFuzzy {:link :CmpIntemAbbrMatch})
(vim.api.nvim_set_hl 0 :CmpItemKindVariable {:bg :NONE :fg "#9CDCFE"})
(vim.api.nvim_set_hl 0 :CmpItemKindInterface {:link :CmpItemKindVariable})
(vim.api.nvim_set_hl 0 :CmpItemKindText {:link :CmpItemKindVariable})
(vim.api.nvim_set_hl 0 :CmpItemKindFunction {:bg :NONE :fg "#C586C0"})
(vim.api.nvim_set_hl 0 :CmpItemKindMethod {:link :CmpItemKindFunction})
(vim.api.nvim_set_hl 0 :CmpItemKindKeyword {:bg :NONE :fg "#D4D4D4"})
(vim.api.nvim_set_hl 0 :CmpItemKindProperty {:link :CmpItemKindKeyword})
(vim.api.nvim_set_hl 0 :CmpItemKindUnit {:link :CmpItemKindKeyword})
(vim.api.nvim_set_hl 0 :LeapBackdrop {:fg "#777777"})
(require :theme.tabby)
(require :theme.line)
(vim.cmd "    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
")
((. (require :nvim-web-devicons) :set_icon) {:norg {:color "#56949f"
                                                    :cterm_color :65
                                                    :icon ""
                                                    :name :Norg}})
