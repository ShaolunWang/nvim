(local tree-opts {:actions {:open_file {:resize_window true
                                        :window_picker {:chars :aoeui}}
                            :remove_file {:close_window false}}
                  :diagnostics {:enable true :show_on_dirs true}
                  :hijack_cursor true
                  :log {:enable true
                        :truncate true
                        :types {:diagnostics true
                                :git true
                                :profile true
                                :watcher true}}
                  ; :on_attach on-attach
                  :renderer {:full_name false
                             :group_empty true
                             :icons {:git_placement :signcolumn
                                     :show {:file true
                                            :folder false
                                            :folder_arrow true
                                            :git false}}
                             :indent_markers {:enable true}}
                  :sync_root_with_cwd true
                  :update_focused_file {:enable true :ignore_list [:help]}
                  :view {:adaptive_size true}})

[{1 :nvim-tree/nvim-tree.lua
  :cmd [:NvimTreeToggle]
  :config (fn []
            ((. (require :nvim-tree) :setup) tree-opts))
  :dependencies [:nvim-tree/nvim-web-devicons]}
 {1 :stevearc/oil.nvim
  :cmd [:Oil]
  :dependencies [:nvim-tree/nvim-web-devicons]
  :opts {:keymaps {:- :actions.parent
                   :<C-c> false
                   :<C-h> false
                   :<C-l> false
                   :<C-p> false
                   :<C-s> false
                   :<C-t> false
                   :<CR> :actions.select
                   :_ :actions.open_cwd
                   "`" :actions.cd
                   :g. :actions.toggle_hidden
                   :g? false
                   "g\\" false
                   :gs false
                   :gx false
                   "~" :actions.tcd}
         :use_default_keymaps false}}]
