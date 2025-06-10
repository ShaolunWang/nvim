M = {}

function M.setup_which_key()
	local wk = require('which-key')
	wk.add({
		{
			mode = 'n',
			{ '<Leader>f', group = '+Fuzzy Search...' },
			{ '<Leader>t', group = '+Tab ...' },
			{ '<Leader>g', desc = '+Grapple ...' },
			{ '\\', group = '+Lsp ...' },
			{ 'g', group = '+g ...' },
			{ ',', group = '+unimpaired ...' },
			{ '[', group = '+unimpaired ...' },
			{ ']', group = '+unimpaired ...' },
			{ ',', group = '+<localleader> ...' },
		},
		{ mode = { 'n', 'v', 'o', 'x' }, { 'r', group = '+surround ...' } },
	})
end
return M
