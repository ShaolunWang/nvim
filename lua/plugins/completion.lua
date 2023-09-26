return {
	'ms-jpq/coq_nvim',
	dependencies = {
		'ms-jpq/coq.thirdparty',
		'ms-jpq/coq.artifacts',
	},
	init = function()
		vim.g.coq_settings = {
			clients = { snippets = { warn = {} } },
			auto_start = 'shut-up',
			keymap = {
				recommended = true,
				jump_to_mark = '<c-m>',
			},
		}
	end,
	branch = 'coq',
	event = 'InsertEnter',
}
