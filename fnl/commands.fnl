(vim.api.nvim_create_user_command 
  :Forecast
	(fn [opts]
	((. (require :wttr) :get_forecast) (string.upper opts.args)))
{:nargs 1})	
