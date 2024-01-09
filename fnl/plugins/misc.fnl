[{1 :numToStr/Comment.nvim
  :config (fn []
            ((. (require :Comment) :setup)))
  :keys [{1 :gc :desc "Comment toggle linewise" :mode [:n :v]}
         {1 :gb :desc "Comment toggle blockwise" :mode [:n :v]}]
  :opts (fn []
          (local (commentstring-avail commentstring)
                 (pcall require
                        :ts_context_commentstring.integrations.comment_nvim))
          (or (and (and commentstring-avail commentstring)
                   {:pre_hook (commentstring.create_pre_hook)})
              {}))}
 {1 :tversteeg/registers.nvim
  :cmd :Registers
  :config (fn []
            ((. (require :registers) :setup) {:bind_keys {:insert false
                                                          :normal false}}))
  :keys [{1 "\"" :mode [:n :v]}]}
 {1 :kevinhwang91/nvim-bqf
  :ft [:qf]
  :dependencies [:gabrielpoca/replacer.nvim]
  :opts {:func_enable {:drop :d
                       :openc :o
                       :ptogglemode "z,"
                       :split :<C-v>
                       :tabc ""
                       :tabdrop :<C-t>}
         :preview {:win_height 999 :win_vheight 999}}}
 {1 :jinh0/eyeliner.nvim :opts {:dim false :highlight_on_key true}}
 {1 :boarg/grapple.nvim
  :dependencies [:nvim-lua/plenary.nvim]
  :keys [:<Leader>]
  :opts {:popup_options {:border :single
                         :focusable false
                         :height 12
                         :relative :editor
                         :style :minimal
                         :width 60}
         :scope :directory}}
 {1 :chrisgrieser/nvim-origami :event :BufReadPost :opts true}
 {1 :AndrewRadev/bufferize.vim :cmd [:Bufferize]}
 {1 :chrisgrieser/nvim-origami :event :BufReadPost :opts true}
 {1 :ggandor/leap.nvim
  :config (fn []
            (tset (. (require :leap) :opts)
                  :highlight_unlabeled_phase_one_targets true))}
 {1 :j-hui/fidget.nvim
  :config (fn []
            ((. (require :fidget) :setup)
			 	{:notification 
				{:configs {:default {:annote_style :Question
				:debug_annote :DEBUG :debug_style :Comment
				:error_annote :ERROR :error_style :ErrorMsg
				:group_style :Title
				:icon "" :icon_style :Special
				:info_annote :INFO :name "" :ttl 5
				:warn_annote :WARN :warn_style :WarningMsg}}
				:override_vim_notify true}}))}
 [:hauleth/asyncdo.vim]
 {1 :hedyhli/outline.nvim :cmd [:Outline :OutlineOpen] :opts {}}
 {1 :lazymaniac/wttr.nvim :dependencies [:nvim-lua/plenary.nvim :MunifTanjim/nui.nvim] :opts {}}
 {1 :m-demare/hlargs.nvim :event :BufReadPost}
 ]
