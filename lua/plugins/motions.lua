local M = {}
M.plugins = {
	{ src = 'https://github.com/folke/flash.nvim' },
	{ src = 'https://github.com/kwkarlwang/bufjump.nvim' },
	{ src = 'https://github.com/chentoast/marks.nvim' },
	{ src = 'https://github.com/cbochs/grapple.nvim' },
	{ src = 'https://github.com/mrjones2014/smart-splits.nvim' },
}
function M.load()
	require('lze').load({
		{
			'flash.nvim',
			after = function()
				require('flash').setup({
					label = { rainbow = { enabled = true } },
					jump = {
						nohlsearch = true,
					},
					modes = {
						char = {
							enabled = true,
							multi_line = false,
							autohide = true,
							jump_labels = true,
							highlight = { backdrop = false },
						},
					},
					search = {
						exclude = require('utils.exclude_ft'),
						mode = 'exact',
					},
				})
			end,
			keys = {
				{
					'<c-q>',
					mode = 'n',
					function()
						require('utils.jump').two_label()
					end,
					desc = 'Jump 2c',
				},
			},
		},
		{
			'grapple.nvim',
			-- at this point plenary should be loaded by fundo
			after = function()
				local grapple = require('grapple')
				require('grapple').setup()

				vim.keymap.set('n', '<leader>gg', grapple.toggle, { desc = 'Grapple Tag' })
				vim.keymap.set('n', '<leader>gr', grapple.reset, { desc = 'Grapple Clear' })
				vim.keymap.set('n', '<leader>gp', grapple.open_tags, { desc = 'Grapple Menu' })
				vim.keymap.set('n', '[g', function()
					grapple.cycle_tags('prev')
				end, { desc = 'Grapple Prev' })
				vim.keymap.set('n', ']g', function()
					grapple.cycle_tags('next')
				end, { desc = 'Grapple Next' })
			end,

			keys = { '<leader>g', '[g', ']g' },
		},
		{
			'smart-splits.nvim',
			after = function()
				require('smart-splits').setup({
					ignored_buftypes = {
						'prompt',
					},
				})
			end,
			event = { 'WinEnter' },
		},
		{
			'bufjump.nvim',
			after = function()
				require('bufjump').setup()
			end,
			keys = { 'c-o', 'c-i' },
		},
		{
			'marks.nvim',
			after = function()
				require('marks').setup()
			end,
			keys = { 'm' },
		},
	})
end

return M
