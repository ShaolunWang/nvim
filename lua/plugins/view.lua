local M = {}
M.plugins = {
	{ 'folke/todo-comments.nvim', opt = true },
	{ 'stevearc/quicker.nvim', opt = true },
	{ 'tzachar/highlight-undo.nvim', opt = true },
	{ 'sindrets/winshift.nvim', opt = true },
	-- { 'nvimtools/hydra.nvim', opt = true },
}
function M.load()
	require('lze').load({

		{
			'todo-comments.nvim',
			after = function()
				require('todo-comments').setup({
					keywords = {
						FIX = {
							icon = ' ',
							color = 'error',
							alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
						},
						TODO = { icon = ' ', color = 'info' },
						HACK = { icon = ' ', color = 'warning' },
						WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
						PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
						NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
						TEST = { icon = '? ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
					},
				})
			end,
			event = 'BufReadPost',
		},
		{
			'quicker.nvim',
			after = function()
				require('quicker').setup({
					max_filename_width = function()
						return math.floor(math.min(45, vim.o.columns / 2))
					end,
					follow = { enabled = true },
					highlight = {
						-- Use treesitter highlighting
						treesitter = true,
						-- Use LSP semantic token highlighting
						lsp = true,
						-- Load the referenced buffers to apply more accurate highlights (may be slow)
						load_buffers = false,
					},
				})
			end,
			event = 'FileType qf',
			on_require = { 'quicker' },
		},
		{
			'highlight-undo.nvim',
			keys = { { 'u' }, { '<C-r>' } },
		},
		{
			'winshift.nvim',
			after = function()
				require('winshift').setup({
					moving_win_options = {
						wrap = true,
						cursorline = false,
						cursorcolumn = false,
					},
				})
			end,
			cmd = { 'WinShift' },
		},
		--[[ 		{
			'hydra.nvim',
			after = function()
				require('hydra').setup({
					timeout = 1000,
				})
				require('utils.hydra').hydra_setup()
			end,
			--			keys = { '<c-w>' },
		}, ]]
	})
end

return M
