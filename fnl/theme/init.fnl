(set vim.g.showtabline 3)
(set vim.g.termguicolors true)
(vim.cmd "colorscheme github_dark_high_contrast")
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
; (local ts-extra-highlights
;        {:@text.danger {:bold true :link Error-msg}
;         :@text.diff.add {:link Diff-add}
;         :@text.diff.delete {:fg Diff-delete}
;         :@text.emphasis {:italic true}
;         :@text.environment {:link Keyword}
;         :@text.environment.name {:link String}
;         :@text.literal {:link "@parameters"}
;         :@text.math {:link Constant}
;         :@text.note {:bold true :italic true}
;         :@text.quote {:link String}
;         :@text.strong {:bold true}
;         :@text.title {:link Function}
;         :@text.warning {:bold true :link Warning-msg}})
; (each [group color (pairs ts-extra-highlights)]
;  (vim.api.nvim_set_hl 0 group color))
(vim.api.nvim_set_hl 0 :LeapBackdrop {:fg "#777777"})
(require :theme.tabby)
(require :theme.line)
(vim.cmd "    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
")	
