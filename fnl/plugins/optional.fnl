[{1 :craigemery/vim-autotag :ft [:cpp]}
                      {1 :bfrg/vim-cpp-modern
                       :config (fn []
                                 (vim.cmd "\t       let g:cpp_attributes_highlight = 1
\t       let g:cpp_member_highlight = 1
\t     "))
                       :ft [:c :cpp :h :hpp]}
                      {1 :preservim/tagbar :cmd [:Tagbar]}
                      {1 :NeogitOrg/neogit
                       :cmd :Neogit
                       :dependencies [:nvim-lua/plenary.nvim
                                      :sindrets/diffview.nvim
                                      :nvim-telescope/telescope.nvim]
                       :opts {:auto_refresh true
                              :disable_builtin_notifications false
                              :integrations {:diffview true}
                              :kind :tab
                              :use_magit_keybindings true}}
                      {1 :ludovicchabant/vim-gutentags
                       :config (fn []
                                 (set vim.g.gutentags_generate_on_new true)
                                 (set vim.g.gutentags_generate_on_missing true)
                                 (set vim.g.gutentags_generate_on_write true)
                                 (set vim.g.gutentags_generate_on_empty_buffer
                                      true)
                                 (set vim.g.gutentags_define_advanced_commands
                                      true)
                                 (set vim.g.gutentags_add_default_project_roots
                                      false)
                                 (set vim.g.gutentags_modules [:cscope_maps])
                                 (set vim.g.gutentags_cscope_build_inverted_index_maps
                                      1)
                                 (set vim.g.gutentags_file_list_command
                                      "fd -e cpp -e h")
                                 (set vim.g.gutentags_project_root [:.root]))
                       :dependencies [:dhananjaylatkar/cscope_maps.nvim]
                       :ft [:cpp :h :hpp]}
                      {1 :dhananjaylatkar/cscope_maps.nvim
                       :config (fn []
                                 (set vim.g.neovide_cursor_animation_length 0)
                                 (set vim.g.neovide_cursor_animate_in_insert_mode
                                      false)
                                 (set vim.g.neovide_cursor_trail_size 0)
                                 ((. (require :cscope_maps) :setup) {:cscope {:db_build_cmd_args [:-bqkv
                                                                                                  :-i
                                                                                                  :cscope.files]
                                                                              :exec :gtags-cscope
                                                                              :picker :telescope
                                                                              :skip_picker_for_single_result false}})
                                 (vim.cmd "     function FormatBuffer()
       if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
         let cursor_pos = getpos('.')
         :%!clang-format
         call setpos('.', cursor_pos)
       endif
     endfunction
     
     autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()
  ")
                                 (local sym-map
                                        {:a :Assignment
                                         :c "Functions Calling this"
                                         :d "Functions called"
                                         :e "EGrep Pattern"
                                         :f :File
                                         :g :Def
                                         :i "Files #including this File"
                                         :s :Symbol
                                         :t "Text String"})

                                 (fn get-cscope-prompt-cmd [operation
                                                            selection]
                                   (var sel :cword)
                                   (when (= selection :f) (set sel :cfile))
                                   (string.format "<cmd>lua require('cscope_maps').cscope_prompt('%s', vim.fn.expand(\"<%s>\"))<cr>"
                                                  operation sel))

                                 (vim.keymap.set :n :<leader>cs
                                                 (get-cscope-prompt-cmd :s :w)
                                                 {:desc sym-map.s
                                                  :noremap true
                                                  :silent true})
                                 (vim.keymap.set :n :<leader>cg
                                                 (get-cscope-prompt-cmd :g :w)
                                                 {:desc sym-map.g
                                                  :noremap true
                                                  :silent true})
                                 (vim.keymap.set :n :<leader>cc
                                                 (get-cscope-prompt-cmd :c :w)
                                                 {:desc sym-map.c
                                                  :noremap true
                                                  :silent true})
                                 (vim.keymap.set :n :<leader>ct
                                                 (get-cscope-prompt-cmd :t :w)
                                                 {:desc sym-map.t
                                                  :noremap true
                                                  :silent true})
                                 (vim.keymap.set :n :<leader>ce
                                                 (get-cscope-prompt-cmd :e :w)
                                                 {:desc sym-map.e
                                                  :noremap true
                                                  :silent true})
                                 (vim.keymap.set :n :<leader>cf
                                                 (get-cscope-prompt-cmd :f :f)
                                                 {:desc sym-map.f
                                                  :noremap true
                                                  :silent true})
                                 (vim.keymap.set :n :<leader>ci
                                                 (get-cscope-prompt-cmd :i :f)
                                                 {:desc sym-map.i
                                                  :noremap true
                                                  :silent true})
                                 (vim.keymap.set :n :<leader>cd
                                                 (get-cscope-prompt-cmd :d :w)
                                                 {:desc sym-map.d
                                                  :noremap true
                                                  :silent true})
                                 (vim.keymap.set :n :<leader>ca
                                                 (get-cscope-prompt-cmd :a :w)
                                                 {:desc sym-map.a
                                                  :noremap true
                                                  :silent true})
                                 (vim.keymap.set :n "<C-]>"
                                                 "<cmd>exe \"Cstag\" expand(\"<cword>\")<cr>"
                                                 {:desc :ctag
                                                  :noremap true
                                                  :silent true})
                                 (set vim.b.miniclue_config
                                      {:clues [{:desc "+Cscope Find ..."
                                                :keys :<Leader>c
                                                :mode :n}]}))
                       :dependencies [:nvim-telescope/telescope.nvim
                                      :nvim-tree/nvim-web-devicons]
                       :ft [:cpp :h :hpp]}
]

