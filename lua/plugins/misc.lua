-- :fennel:1704814406
local function _1_()
	return require('Comment').setup()
end
local function _2_()
	local commentstring_avail, commentstring = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
	return (((commentstring_avail and commentstring) and { pre_hook = commentstring.create_pre_hook() }) or {})
end
local function _3_()
	return require('registers').setup({ bind_keys = { insert = false, normal = false } })
end
local function _4_()
	require('leap').opts['highlight_unlabeled_phase_one_targets'] = true
	return nil
end
local function _5_()
	return require('fidget').setup({
		notification = {
			configs = {
				default = {
					annote_style = 'Question',
					debug_annote = 'DEBUG',
					debug_style = 'Comment',
					error_annote = 'ERROR',
					error_style = 'ErrorMsg',
					group_style = 'Title',
					icon = '',
					icon_style = 'Special',
					info_annote = 'INFO',
					name = '',
					ttl = 5,
					warn_annote = 'WARN',
					warn_style = 'WarningMsg',
				},
			},
			override_vim_notify = true,
		},
	})
end
return {
	{
		'numToStr/Comment.nvim',
		config = _1_,
		keys = {
			{ 'gc', desc = 'Comment toggle linewise', mode = { 'n', 'v' } },
			{ 'gb', desc = 'Comment toggle blockwise', mode = { 'n', 'v' } },
		},
		opts = _2_,
	},
	{ 'tversteeg/registers.nvim', cmd = 'Registers', config = _3_, keys = { { '"', mode = { 'n', 'v' } } } },
	{
		'kevinhwang91/nvim-bqf',
		ft = { 'qf' },
		dependencies = { 'gabrielpoca/replacer.nvim' },
		opts = {
			func_enable = { drop = 'd', openc = 'o', ptogglemode = 'z,', split = '<C-v>', tabc = '', tabdrop = '<C-t>' },
			preview = { win_height = 999, win_vheight = 999 },
		},
	},
	{ 'jinh0/eyeliner.nvim', opts = { highlight_on_key = true, dim = false } },
	{
		'boarg/grapple.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = { '<Leader>' },
		opts = {
			popup_options = {
				border = 'single',
				height = 12,
				relative = 'editor',
				style = 'minimal',
				width = 60,
				focusable = false,
			},
			scope = 'directory',
		},
	},
	{ 'chrisgrieser/nvim-origami', event = 'BufReadPost', opts = true },
	{ 'AndrewRadev/bufferize.vim', cmd = { 'Bufferize' } },
	{ 'chrisgrieser/nvim-origami', event = 'BufReadPost', opts = true },
	{ 'ggandor/leap.nvim', config = _4_ },
	{ 'j-hui/fidget.nvim', config = _5_ },
	{ 'hauleth/asyncdo.vim' },
	{ 'hedyhli/outline.nvim', cmd = { 'Outline', 'OutlineOpen' }, opts = {} },
	{ 'lazymaniac/wttr.nvim', dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' }, opts = {} },
	{ 'm-demare/hlargs.nvim', event = 'BufReadPost' },
}
