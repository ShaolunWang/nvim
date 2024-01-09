;(require :globals)

(require :config)

(require :plug)
(require :theme)
(require :keymap)
(require :autocmd)
(require :commands)
(when vim.loader
  (vim.loader.enable))

(tset vim.g :loader_luv true)
