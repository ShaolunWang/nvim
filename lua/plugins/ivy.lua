return {
	'AdeAttwood/ivy.nvim',
	opts = {
		backends = {
			{ 'ivy.backends.rg', { keymap = '<c-x><c-g>' } },
			{ 'ivy.backends.lsp-workspace-symbols', { keymap = '<c-x><c-l>' } },
		},
	},
	build = 'cargo build --release',
}
