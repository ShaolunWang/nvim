return {
	'ggandor/leap.nvim',
	config = function()
		require('leap').opts.highlight_unlabeled_phase_one_targets = true
	end,
}
