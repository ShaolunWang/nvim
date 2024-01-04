;(require :globals)

(require :config)

(require :plugins)
(when vim.loader
  (vim.loader.enable))
(tset vim.g :loader_luv true)
