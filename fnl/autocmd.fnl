(vim.api.nvim_create_augroup :yank_highlight {})
(vim.api.nvim_create_autocmd :BufReadPost
                             {:callback (fn []
                                          (local mark
                                                 (vim.api.nvim_buf_get_mark 0
                                                                            "\""))
                                          (local lcount
                                                 (vim.api.nvim_buf_line_count 0))
                                          (when (and (> (. mark 1) 0)
                                                     (<= (. mark 1) lcount))
                                            (pcall vim.api.nvim_win_set_cursor
                                                   0 mark)))})

(vim.api.nvim_create_autocmd :TextYankPost
                             {:callback (fn [] (local fidget (require :fidget))
                                          (fidget.notify :yanking)
                                          (vim.highlight.on_yank {:higroup :IncSearch
                                                                  :timeout 400}))
                              :group :yank_highlight
                              :pattern "*"})

(vim.api.nvim_create_autocmd :FileType
                             {:callback (fn []
                                          (vim.api.nvim_buf_set_keymap 0 :n
                                                                       "<,o>"
                                                                       :<cmd>colder<CR>
                                                                       {:noremap true
                                                                        :silent true})
                                          (vim.api.nvim_buf_set_keymap 0 :n
                                                                       "<,i>"
                                                                       :<cmd>cnewer<CR>
                                                                       {:noremap true
                                                                        :silent true}))
                              :pattern :qf})

(local llvm-highlight (vim.api.nvim_create_augroup :llvm-highlight {}))
(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:callback (fn [] (vim.cmd "set ft=mlir"))
                              :group llvm-highlight
                              :pattern [:*.mlir :*.xdsl]})

(vim.cmd "au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif")
(vim.api.nvim_create_autocmd :FileType
                             {:callback (fn [] (vim.cmd "set ft=tablegen"))
                              :group llvm-highlight
                              :pattern [:*.td]})

(vim.api.nvim_clear_autocmds {:event :BufLeave :group :Grapple})
