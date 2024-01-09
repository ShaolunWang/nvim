(local conditions (require :heirline.conditions))
(local utils (require :heirline.utils))
(local M {})
(local Align {:provider "%="})
(local Separator {:provider " "})
(local Space {:provider " "})
((. (require :heirline) :load_colors) {:blue "#005078"
                                       :cyan "#007676"
                                       :green "#015825"
                                       :grey1 "#0a0b10"
                                       :grey2 "#1c1d23"
                                       :grey3 "#2c2e33"
                                       :grey4 "#4f5258"
                                       :magenta "#4c0049"
                                       :red "#5e0009"
                                       :yellow "#6e5600"})
(local Vi-mode {:hl (fn [self] (local mode (self.mode:sub 1 1))
                      {:bold true :fg (. self.mode_colors mode)})
                :init (fn [self]
                        (set self.mode (vim.fn.mode 1))
                        (when (not self.once)
                          (vim.api.nvim_create_autocmd :ModeChanged
                                                       {:command :redrawstatus})
                          (set self.once true)))
                :provider (fn [self]
                            (.. "%2(" (. self.mode_names self.mode) "%)"))
                :static {:mode_colors {"\019" :purple
                                       "\022" :cyan
                                       :! :red
                                       :R :orange
                                       :S :purple
                                       :V :cyan
                                       :c :orange
                                       :i :green
                                       :n :green
                                       :r :orange
                                       :s :purple
                                       :t :red
                                       :v :cyan}
                         :mode_names {"\019" :^S
                                      "\022" :^V
                                      "\022s" :^V
                                      :! "!"
                                      :R :R
                                      :Rc :Rc
                                      :Rv :Rv
                                      :Rvc :Rv
                                      :Rvx :Rv
                                      :Rx :Rx
                                      :S :S_
                                      :V :V_
                                      :Vs :Vs
                                      :c :C
                                      :cv :Ex
                                      :i :I
                                      :ic :Ic
                                      :ix :Ix
                                      :n :N
                                      :niI :Ni
                                      :niR :Nr
                                      :niV :Nv
                                      :no :N?
                                      "no\022" :N?
                                      :noV :N?
                                      :nov :N?
                                      :nt :Nt
                                      :r "..."
                                      :r? "?"
                                      :rm :M
                                      :s :S
                                      :t :T
                                      :v :V
                                      :vs :Vs}}
                :update :ModeChanged})
(local File-name {:hl {:fg (. (utils.get_highlight :Directory) :fg)}
                  :provider (fn [self]
                              (var filename
                                   (vim.fn.fnamemodify self.filename ":."))
                              (when (= filename "")
                                (lua "return \"[No Name]\""))
                              (when (not (conditions.width_percent_below (length filename)
                                                                         0.25))
                                (set filename (vim.fn.pathshorten filename)))
                              filename)})
(local Help-file-name
       {:condition (fn [] (= vim.bo.filetype :help))
        :hl {:fg :blue}
        :provider (fn [] (local filename (vim.api.nvim_buf_get_name 0))
                    (vim.fn.fnamemodify filename ":t"))})
(local File-flags [{:condition (fn [] vim.bo.modified)
                    :hl {:fg :green}
                    :provider "[+]"}
                   {:condition (fn []
                                 (or (not vim.bo.modifiable) vim.bo.readonly))
                    :hl {:fg :orange}
                    :provider ""}])
(local Work-dir {:hl {:fg (. (utils.get_highlight :Directory) :bg)}
                 :provider (fn [] (var cwd (vim.fn.expand "%"))
                             (set cwd (vim.fn.fnamemodify cwd ":~"))
                             cwd)})
(local Default-statusline [Vi-mode
                           Space
                           Separator
                           File-flags
                           Space
                           Work-dir
                           Space])
(local Inactive-statusline
       {1 Separator
        2 File-name
        3 Align
        :condition (fn [] (not (conditions.is_active)))})
(local Terminal-name {:hl {:bold true :fg :blue}
                      :provider (fn []
                                  (local (tname _)
                                         (: (vim.api.nvim_buf_get_name 0) :gsub
                                            ".*:" ""))
                                  (.. " " tname))})	
(local Terminal-statusline
       {1 {1 Vi-mode 2 Separator :condition conditions.is_active}
        2 Terminal-name
        3 Align
        :condition (fn []
                     (conditions.buffer_matches {:buftype [:terminal]}))})
(local Special-statusline
       {1 Separator
        2 Help-file-name
        3 Align
        :condition (fn []
                     (conditions.buffer_matches {:buftype [:nofile
                                                           :prompt
                                                           :help
                                                           :quickfix]
                                                 :filetype [:^git.* :fugitive]}))})
(local Status-lines {1 Special-statusline
                     2 Terminal-statusline
                     3 Inactive-statusline
                     4 Default-statusline
                     :fallthrough false})
((. (require :heirline) :setup) {:statusline Status-lines})
M	
