-- :fennel:1704795732
local function _1_(opts)
  return require("wttr").get_forecast(string.upper(opts.args))
end
return vim.api.nvim_create_user_command("Forecast", _1_, {nargs = 1})