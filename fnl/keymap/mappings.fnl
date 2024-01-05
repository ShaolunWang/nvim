(local map vim.api.nvim_set_keymap)
(vim.keymap.set :n :<leader>gg
                (fn []
                  ((. (require :grapple) :toggle) {:use_cursor true}))
                {:desc "Grappled Toggle"})
(vim.keymap.set :n :<leader>gp (. (require :grapple) :popup_tags)
                {:desc "Grappled Popup"})
(vim.keymap.set :n :<leader>gr (. (require :grapple) :reset)
                {:desc "Grappled Reset"})
(vim.keymap.set :n :<c-n>
                (fn []
                  (if (= vim.bo.filetype :oil) ((. (require :oil) :close))
                      ((. (require :oil) :open))))
                {:desc "File navigation"})
(vim.keymap.set :n :<leader>n ":Neorg<cr>" {:desc :Neorg :noremap true})
(vim.keymap.set :n "  " ":noh<CR>" {:noremap true})
(vim.keymap.set [:n :x :o] :s
                (fn []
                  ((. (require :leap) :leap) {:inclusive_op true :offset (- 1)}))
                {:desc "leap forward till" :noremap true :silent true})
(vim.keymap.set [:n :x :o] :S
                (fn []
                  ((. (require :leap) :leap) {:backward true :offset 2}))
                {:desc "leap backward till" :noremap true :silent true})
(vim.keymap.set :n ",v" :<c-v> {:desc "visual select"})
(vim.keymap.set :n :<C-h> :<C-w>h)
(vim.keymap.set :n :<C-j> :<C-w>j)
(vim.keymap.set :n :<C-k> :<C-w>k)
(vim.keymap.set :n :<C-l> :<C-w>l)
(fn fuzzy-keymaps []
  (if (not= (. (vim.loop.os_uname) :sysname) :Windows)
      (do
        (vim.keymap.set :n :<leader>ff
                        (fn []
                          ((. (require :fzf-lua) :files)))
                        {:desc "Find File" :noremap true})
        (vim.keymap.set :n :<leader>fg
                        (fn []
                          ((. (require :fzf-lua) :live_grep)))
                        {:desc "Grep content" :noremap true})
        (vim.keymap.set :n :<leader>fh
                        (fn []
                          ((. (require :fzf-lua) :help_tags)))
                        {:desc "Find Help" :noremap true})
        (vim.keymap.set :n :<leader>fo
                        (fn []
                          ((. (require :fzf-lua) :oldfiles)))
                        {:desc "Search Old File" :noremap true})
        (vim.keymap.set :n :<leader>fp ":FzfLua<cr>"
                        {:desc "Custom picker" :noremap true}))
      (do
        (vim.keymap.set :n :<leader>ff
                        (fn []
                          ((. (require :telescope.builtin) :find_files)))
                        {:desc "Find File" :noremap true})
        (vim.keymap.set :n :<leader>fg
                        (fn []
                          ((. (require :telescope.builtin) :live_grep)))
                        {:desc "Grep content" :noremap true})
        (vim.keymap.set :n :<leader>fh
                        (fn []
                          ((. (require :telescope.builtin) :help_tags)))
                        {:desc "Find Help" :noremap true})
        (vim.keymap.set :n :<leader>fo
                        (fn []
                          ((. (require :telescope.builtin) :oldfiles)))
                        {:desc "Search Old File" :noremap true})
        (vim.keymap.set :n :<leader>fp ":Telescope<cr>"
                        {:desc "Custom picker" :noremap true}))))
(vim.keymap.set :n :<leader>tt ":$tabnew<CR>" {:desc "New Tab" :noremap true})
(vim.keymap.set :n :<leader>tc ":tabclose<CR>"
                {:desc "Close Tab" :noremap true})
(vim.keymap.set :n :<leader>to ":tabonly<CR>"
                {:desc "Close Other Tabs" :noremap true})
(vim.keymap.set :n :<leader>tj ":tabn<CR>" {:desc "Next Tab" :noremap true})
(vim.keymap.set :n :<leader>tk ":tabp<CR>" {:desc "Prev Tab" :noremap true})
(vim.keymap.set :n :<leader>th ":-tabmove<CR>"
                {:desc "-Move Tab" :noremap true})
(vim.keymap.set :n :<leader>tl ":+tabmove<CR>"
                {:desc "+Move Tab" :noremap true})
(vim.keymap.set :n "\"\"" ":Registers<cr>"
                {:desc "reg floating window" :noremap true :silent true})
(vim.keymap.set :n :<f5> ":AsyncDo " {:desc :Runner :noremap true})
(fn toggle-qf []
  (each [_ info (ipairs (vim.fn.getwininfo))]
    (when (= info.quickfix 1) (vim.cmd :cclose) (lua "return ")))
  (when (= (next (vim.fn.getqflist)) nil)
    (vim.print "No Quickfix Entry")
    (lua "return "))
  (vim.cmd :copen))
(vim.keymap.set :n :<F6> (fn [] (toggle-qf)) {:noremap true :silent true})
(fn toggle-loclist []
  (each [_ info (ipairs (vim.fn.getwininfo))]
    (when (= info.loclist 1) (vim.cmd :lclose) (lua "return ")))
  (when (= (next (vim.fn.getloclist 0)) nil)
    (vim.print "No Location List Entry")
    (lua "return "))
  (vim.cmd :lopen))
(vim.keymap.set :n :<F7> (fn [] (toggle-loclist)) {:noremap true :silent true})
(fuzzy-keymaps)	
