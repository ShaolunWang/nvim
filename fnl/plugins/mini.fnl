[{1 :echasnovski/mini.clue
  :config (fn []
            (local miniclue (require :mini.clue))
            (miniclue.setup {:clues [{:desc "+Fuzzy Search..."
                                      :keys :<Leader>f
                                      :mode :n}
                                     {:desc "+Tab ..."
                                      :keys :<Leader>t
                                      :mode :n}
                                     {:desc "+Grapple ..."
                                      :keys :<Leader>g
                                      :mode :n}
                                     {:desc "+Lsp ..." :keys "\\" :mode :n}
                                     {:desc "+g ..." :keys :g :mode :n}
                                     {:desc "+unimpaired ..."
                                      :keys ","
                                      :mode :n}
                                     {:desc "+unimpaired ..."
                                      :keys "["
                                      :mode :n}
                                     {:desc "+unimpaired ..."
                                      :keys "]"
                                      :mode :n}
                                     (miniclue.gen_clues.windows {:submode_resize true})]
                             :triggers [{:keys :g :mode :n}
                                        {:keys :<Leader> :mode :n}
                                        {:keys "\\" :mode :n}
                                        {:keys "," :mode :n}
                                        {:keys "[" :mode :n}
                                        {:keys "]" :mode :n}
                                        {:keys :<C-w> :mode :n}]
                             :window {:config {:anchor :SW
                                               :col :auto
                                               :row :auto
                                               :width :auto}
                                      :delay 500}}))
  :keys [:<leader> "\\" :g "," "[" "]" :<c-w>]}
 {1 :echasnovski/mini.hipatterns
  :config (fn []
            (local hipatterns (require :mini.hipatterns))
            (hipatterns.setup {:highlighters {:deprecated {:group :MiniHipatternsFixme
                                                           :pattern "%f[%w]()DEPRECATE()%f[%W]"}
                                              :fixme {:group :MiniHipatternsFixme
                                                      :pattern "%f[%w]()FIXME()%f[%W]"}
                                              :hack {:group :Deprecation
                                                     :pattern "%f[%w]()HACK()%f[%W]"}
                                              :hex_color (hipatterns.gen_highlighter.hex_color)
                                              :note {:group :MiniHipatternsNote
                                                     :pattern "%f[%w]()NOTE()%f[%W]"}
                                              :todo {:group :MiniHipatternsTodo
                                                     :pattern "%f[%w]()TODO()%f[%W]"}}}))
  :version false}
 {1 :echasnovski/mini.move
  :keys ["[" "]" :<e :>e]
  :opts {:mappings {:down "]e"
                    :left :<e
                    :line_down "]e"
                    :line_left :<e
                    :line_right :>e
                    :line_up "[e"
                    :right :>e
                    :up "[e"}
         :options {:reindent_linewise true}}
  :version false}]
