(vim.api.nvim_create_user_command 
  :Forecast
	(fn [opts]
	((. (require :wttr) :get_forecast) (string.upper opts.args)))
{:nargs 1})	

(vim.api.nvim_create_user_command
  :Hatch
   (fn [] ((. (require :duck) :hatch) ) )
  {}
)
(vim.api.nvim_create_user_command
  :Cook
  (fn [] ((. (require :duck) :cook) ))
  {}
)
