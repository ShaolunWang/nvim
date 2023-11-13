return {
	{
		'jbyuki/venn.nvim',
		config = function()
			vim.o.virtualedit = 'all'
		end,
		cmd = { 'VBox' },
	},
	{ 'ellisonleao/glow.nvim', opts = {}, cmd = { 'Glow' } },
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		ft = { 'markdown' },
		build = function()
			vim.fn['mkdp#util#install']()
		end,
	},
}
