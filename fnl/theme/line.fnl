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
(var Vi-mode nil)
(fn /_1- [self]
  (let [mode (self.mode:sub 1 1)] {:bold true :fg (. self.mode_colors mode)}))
(fn /_2- [self]
  (set self.mode (vim.fn.mode 1))
  (if (not self.once) (do
                        (vim.api.nvim_create_autocmd :ModeChanged
                                                     {:command :redrawstatus})
                        (set self.once true)
                        nil) nil))
(fn /_4- [self] (.. "%2(" (. self.mode_names self.mode) "%)"))
(set Vi-mode {:hl /_1-
              :init /_2-
              :provider /_4-
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
(var File-name nil)
(fn /_5- [self]
  (var filename (vim.fn.fnamemodify self.filename ":."))
  (if (= filename "") (lua "return \"[No Name]\"")
      (do
        ))
  (if (not (conditions.width_percent_below (length filename) 0.25))
      (set filename (vim.fn.pathshorten filename))
      (do
        ))
  filename)
(set File-name {:hl {:fg (. (utils.get_highlight :Directory) :fg)}
                :provider /_5-})
(var Help-file-name nil)
(fn /_8- [] (= vim.bo.filetype :help))
(fn /_9- []
  (let [filename (vim.api.nvim_buf_get_name 0)]
    (vim.fn.fnamemodify filename ":t")))
(set Help-file-name {:condition /_8- :hl {:fg :blue} :provider /_9-})
(var File-flags nil)
(fn /_10- [] vim.bo.modified)
(fn /_11- [] (or (not vim.bo.modifiable) vim.bo.readonly))
(set File-flags
     [{:condition /_10- :hl {:fg :green} :provider "[+]"}
      {:condition /_11- :hl {:fg :orange} :provider ""}])
(var Work-dir nil)
(fn /_12- [] (var cwd (vim.fn.expand "%"))
  (set cwd (vim.fn.fnamemodify cwd ":~"))
  cwd)
(set Work-dir {:hl {:fg (. (utils.get_highlight :Directory) :bg)}
               :provider /_12-})
(local Default-statusline [Vi-mode
                           Space
                           Separator
                           File-flags
                           Space
                           Work-dir
                           Space])
(var Inactive-statusline nil)
(fn /_13- [] (not (conditions.is_active)))
(set Inactive-statusline {1 Separator 2 File-name 3 Align :condition /_13-})
(var Terminal-name nil)
(fn /_14- []
  (let [(tname _) (: (vim.api.nvim_buf_get_name 0) :gsub ".*:" "")]
    (.. " " tname)))
(set Terminal-name {:hl {:bold true :fg :blue} :provider /_14-})
(var Terminal-statusline nil)
(fn /_15- []
  (conditions.buffer_matches {:buftype [:terminal]}))
(set Terminal-statusline {1 {1 Vi-mode
                             2 Separator
                             :condition conditions.is_active}
                          2 Terminal-name
                          3 Align
                          :condition /_15-})
(var Special-statusline nil)
(fn /_16- []
  (conditions.buffer_matches {:buftype [:nofile :prompt :help :quickfix]
                              :filetype [:^git.* :fugitive]}))
(set Special-statusline {1 Separator 2 Help-file-name 3 Align :condition /_16-})
(local Status-lines {1 Special-statusline
                     2 Terminal-statusline
                     3 Inactive-statusline
                     4 Default-statusline
                     :fallthrough false})
((. (require :heirline) :setup) {:statusline Status-lines})
M
