local ftMap = {
	vim = 'indent',
	python = { 'indent' },
	cpp = { 'treesitter' },
	git = '',
}
return {
	{
		'chrisgrieser/nvim-origami',
		event = 'BufReadPost', -- later or on keypress would prevent saving folds
		opts = true, -- needed even when using default config
	},
	{
		'kevinhwang91/nvim-ufo',
		dependencies = {
			'kevinhwang91/promise-async',
			{
				'luukvbaal/statuscol.nvim',
				config = function()
					local builtin = require('statuscol.builtin')
					require('statuscol').setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
							{ text = { '%s' }, click = 'v:lua.ScSa' },
							{ text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
						},
					})
				end,
			},
		},
		event = 'BufReadPre',
		opts = {
			close_fold_kinds_on_ft = { 'imports', 'comment' },
			provider_selector = function(bufnr, filetype, buftype)
				return ftMap[filetype]
			end,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local totalLines = vim.api.nvim_buf_line_count(0)
				local foldedLines = endLnum - lnum
				local suffix = (' Lines folded: %d'):format(foldedLines)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				local rAlignAppndx = math.max(math.min(vim.opt.textwidth['_value'], width - 1) - curWidth - sufWidth, 0)
				suffix = (' '):rep(rAlignAppndx) .. suffix
				table.insert(newVirtText, { suffix, 'Comment' })
				return newVirtText
			end,
		},
		config = function()
			vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
			vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
			require('ufo').setup(opts)
		end,
	},
}
