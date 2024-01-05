;(require :globals)

(require :config)

(require :plug)
(require :theme)
(require :keymap)
(require :autocmd)
(when vim.loader
  (vim.loader.enable))

(tset vim.g :loader_luv true)
