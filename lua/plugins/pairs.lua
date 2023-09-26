return {
	'windwp/nvim-autopairs',
	event = 'InsertEnter',
	opts = {},
	config = function()
		local remap = vim.api.nvim_set_keymap
		local npairs = require('nvim-autopairs')
		npairs.setup({ map_bs = false, map_cr = false })
		_G.MUtils = {}

		MUtils.CR = function()
			if vim.fn.pumvisible() ~= 0 then
				if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
					return npairs.esc('<c-y>')
				else
					return npairs.esc('<c-e>') .. npairs.autopairs_cr()
				end
			else
				return npairs.autopairs_cr()
			end
		end
		remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

		MUtils.BS = function()
			if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
				return npairs.esc('<c-e>') .. npairs.autopairs_bs()
			else
				return npairs.autopairs_bs()
			end
		end
		remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
		local npairs = require('nvim-autopairs')
		local Rule = require('nvim-autopairs.rule')
		local cond = require('nvim-autopairs.conds')

		local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
		local rule_eq = Rule('=', '')
			:with_pair(cond.not_inside_quote())
			:with_pair(function(opts)
				local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
				if last_char:match('[%w%=%s]') then
					return true
				end
				return false
			end)
			:replace_endpair(function(opts)
				local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
				local next_char = opts.line:sub(opts.col, opts.col)
				next_char = next_char == ' ' and '' or ' '
				if prev_2char:match('%w$') then
					return '<bs> =' .. next_char
				end
				if prev_2char:match('%=$') then
					return next_char
				end
				if prev_2char:match('=') then
					return '<bs><bs>=' .. next_char
				end
				return ''
			end)
			:set_end_pair_length(0)
			:with_move(cond.none())
			:with_del(cond.none())
		rule_eq.not_filetypes = { 'xml' }
		npairs.add_rules({ rule_eq })
		-- For each pair of brackets we will add another rule
		for _, bracket in pairs(brackets) do
			npairs.add_rules({
				-- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
				Rule(bracket[1] .. ' ', ' ' .. bracket[2])
					:with_pair(cond.none())
					:with_move(function(opts)
						return opts.char == bracket[2]
					end)
					:with_del(cond.none())
					:use_key(bracket[2])
					-- Removes the trailing whitespace that can occur without this
					:replace_map_cr(function(_)
						return '<C-c>2xi<CR><C-c>O'
					end),
			})
		end
	end,
}
