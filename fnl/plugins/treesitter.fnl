{1 :nvim-treesitter/nvim-treesitter
 :config (fn [_ opts]
           ((. (require :nvim-treesitter.configs) :setup) opts))
 :event [:BufReadPre]
 :opts {:ensure_installed [:c :cpp :lua :python :vim]
        :highlight {:enable true}}}
