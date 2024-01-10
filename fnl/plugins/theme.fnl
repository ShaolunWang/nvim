[[:fynnfluegge/monet.nvim]
 [:projekt0n/github-nvim-theme]
 {1 :nanozuki/tabby.nvim
  :config (fn []
            (set vim.opt.sessionoptions [:buffers :tabpages :globals])
            ((. (require :scope) :setup) {})
            ((. (require :tabby) :setup) {}))
  :dependencies [:tiagovla/scope.nvim]
  :event :VeryLazy}
 {1 :rebelot/heirline.nvim :event :VeryLazy}
 {1 :fynnfluegge/monet.nvim}
 {1 :rebelot/kanagawa.nvim}
 ]
