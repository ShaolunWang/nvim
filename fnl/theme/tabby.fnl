(local theme {:current_tab :TabLineSel
              :fill :TabLineFill
              :head :TabLine
              :tab :TabLine
              :tail :TabLine
              :win :TabLine})
((. (require :tabby.tabline) :set) (fn [line]
                                     {1 ((. (line.tabs) :foreach) (fn [tab]
                                                                    (let [hl (or :TabLineSel
                                                                                 theme.tab)]
                                                                      {1 (line.sep ""
                                                                                   hl
                                                                                   :TablineFill)
                                                                       2 (or (and (tab.is_current)
                                                                                  "")
                                                                             "󰆣")
                                                                       3 (tab.number)
                                                                       4 (tab.name)
                                                                       5 (tab.close_btn "")
                                                                       6 (line.sep ""
                                                                                   hl
                                                                                   :TablineFill)
                                                                       : hl
                                                                       :margin " "})))
                                      2 (line.spacer)
                                      3 ((. (line.wins_in_tab (line.api.get_current_tab))
                                            :foreach) (fn [win]
                                                                                                                                                  {1 (line.sep ""
                                                                                                                                                               :TabLineSel
                                                                                                                                                               :TablineFill)
                                                                                                                                                   2 (or (and (win.is_current)
                                                                                                                                                              "")
                                                                                                                                                         "")
                                                                                                                                                   3 (win.buf_name)
                                                                                                                                                   4 (line.sep ""
                                                                                                                                                               :TabLineSel
                                                                                                                                                               :TablineFill)
                                                                                                                                                   :hl :TabLineSel
                                                                                                                                                   :margin " "}))
                                      4 [{1 "  " :hl :TablLineFill}]
                                      :hl :TablineFill}))	
