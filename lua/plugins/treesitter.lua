local M = {}
M.plugins = {
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
	{ src = 'https://github.com/andymass/vim-matchup' },
	{ src = 'https://github.com/mizlan/iswap.nvim' },
	--	{ 'chrisgrieser/nvim-various-textobjs',          opt = true },
	{ src = 'https://github.com/Badhi/nvim-treesitter-cpp-tools' },
}
function M.load()
	require('lze').load({
		{
			'nvim-treesitter',
			dep_of = { 'markview.nvim', 'nvim-treesitter' },
			after = function()
				require('lze').load({ 'nvim-treesitter-textobjects' })
				local opts = {
					ensure_installed = {
						'c',
						'cpp',
						'lua',
						'python',
						'vim',
						'vimdoc',
					},
					highlight = { enable = true },
					matchup = { enable = true },
					textobjects = {
						select = {
							enable = true,
							keymaps = {
								['iv'] = { query = '@parameter.inner', desc = 'inner parameter' },
							},
						},
					},
				}
				require('nvim-treesitter.configs').setup(opts)
				require('nvim-treesitter.install').compilers = { 'gcc' }
			end,
			event = { 'BufRead' },
		},
		--[[ {
			'nvim-various-textobjs',
			event = 'BufReadPre',
		}, ]]
		{ 'vim-matchup', dep_of = 'nvim-treesitter' },
		{
			'iswap.nvim',
			cmd = { 'ISwapNode', 'IMove', 'ISwap', 'ISwapWith' },
		},
		{
			'nvim-treesitter-cpp-tools',
			-- no need of dep_of, it's already loaded at this stage
			after = function()
				require('nt-cpp-tools').setup({
					preview = {
						quit = 'q', -- optional keymapping for quit preview
						accept = '<tab>', -- optional keymapping for accept preview
					},
					header_extension = 'h', -- optional
					source_extension = 'cpp', -- optional
					custom_define_class_function_commands = { -- optional
						TSCppImplWrite = {
							output_handle = require('nt-cpp-tools.output_handlers').get_add_to_cpp(),
						},
						--[[
                <your impl function custom command name> = {
                    output_handle = function (str, context)
                        -- string contains the class implementation
                        -- do whatever you want to do with it
                    end
                }
                ]]
					},
				})
			end,
			ft = { 'cpp', 'h' },
		},
	})
end

return M
