local M = {}
M.plugins = {
	{ 'echasnovski/mini.icons' },
	{ 'folke/todo-comments.nvim', opt = true },
	{ 'stevearc/quicker.nvim', opt = true },
	{ 'aidancz/buvvers.nvim', opt = true },
	{ 'tzachar/highlight-undo.nvim', opt = true },
	{ 'stevearc/dressing.nvim', opt = true },
	{ 'sindrets/winshift.nvim', opt = true },
}
function M.load()
	require('lze').load({

		{ 'nvim-web-devicons', enabled = false, optional = true },
		{
			'mini.icons',
			after = function()
				require('mini.icons').setup({})
				require('mini.icons').mock_nvim_web_devicons()
			end,
		},
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
		},
		--[[ {
		'kevinhwang91/nvim-bqf',
		opts = {
			preview = { auto_preview = false },
		},
		ft = { 'qf' },
	}, ]]
		{
			'highlight-undo.nvim',
			keys = { { 'u' }, { '<C-r>' } },
		},
		{
			'dressing.nvim',
			after = function()
				require('dressing').setup({
					input = { enabled = true },
					select = {
						enabled = false,
						--[[
				backend = { 'pick', 'nui', 'fzf_lua', 'builtin' },
 				nui = {
					buf_options = {
						filetype = 'nui',
					},
				}, ]]
					},
				})
			end,
			event = 'UIEnter',
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
		{
			'buvvers.nvim',
			after = function()
				require('buvvers').setup()
			end,
			cmd = { 'B' },
			on_require = { 'buvvers' },
		},
	})
end

return M
