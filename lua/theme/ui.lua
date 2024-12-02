M = {}
function M.get_prompt_text(prompt, default_prompt)
	local prompt_text = prompt or default_prompt
	if prompt_text:sub(-1) == ':' then
		prompt_text = '[' .. prompt_text:sub(1, -2) .. ']'
	end
	return prompt_text
end

local Input = require('nui.input')
local event = require('nui.utils.autocmd').event
local config = {
	position = '50%',
	size = nil,
	relative = 'editor',
	border = {
		style = 'rounded',
	},
	buf_options = {
		swapfile = false,
		filetype = 'DressingSelect',
	},
	win_options = {
		winblend = 0,
	},
	max_width = 80,
	max_height = 40,
	min_width = 40,
	min_height = 10,
}
function M.override_ui_input()
	local UIInput = Input:extend('UIInput')

	function UIInput:init(opts, on_done)
		local border_top_text = get_prompt_text(opts.prompt, '[Input]')
		local default_value = tostring(opts.default or '')

		UIInput.super.init(self, {
			relative = 'cursor',
			position = {
				row = 1,
				col = 0,
			},
			size = {
				-- minimum width 20
				width = math.max(20, vim.api.nvim_strwidth(default_value)),
			},
			border = {
				style = 'rounded',
				text = {
					top = border_top_text,
					top_align = 'left',
				},
			},
			win_options = {
				winhighlight = 'NormalFloat:Normal,FloatBorder:Normal',
			},
		}, {
			default_value = default_value,
			on_close = function()
				on_done(nil)
			end,
			on_submit = function(value)
				on_done(value)
			end,
		})

		-- cancel operation if cursor leaves input
		self:on(event.BufLeave, function()
			on_done(nil)
		end, { once = true })

		-- cancel operation if <Esc> is pressed
		self:map('n', '<Esc>', function()
			on_done(nil)
		end, { noremap = true, nowait = true })
	end

	local input_ui

	vim.ui.input = function(opts, on_confirm)
		assert(type(on_confirm) == 'function', 'missing on_confirm function')

		if input_ui then
			-- ensure single ui.input operation
			vim.api.nvim_err_writeln('busy: another input is pending!')
			return
		end

		input_ui = UIInput(opts, function(value)
			if input_ui then
				-- if it's still mounted, unmount it
				input_ui:unmount()
			end
			-- pass the input value
			on_confirm(value)
			-- indicate the operation is done
			input_ui = nil
		end)

		input_ui:mount()
	end
end

local Menu = require('nui.menu')
local event = require('nui.utils.autocmd').event

-- function M.override_ui_select()
-- 	vim.ui.select = function(items, opts, on_choice)
-- 		opts.format_item = function(line)
-- 			return string.gsub(tostring(line), '\n', ' ')
-- 		end
-- 		local Menu = require('nui.menu')
-- 		local event = require('nui.utils.autocmd').event
-- 		local lines = {}
-- 		local line_width = opts.prompt and vim.api.nvim_strwidth(opts.prompt) or 1
-- 		for i, item in ipairs(items) do
-- 			vim.print(item)
-- 			local line = opts.format_item(item)
-- 			line_width = math.max(line_width, vim.api.nvim_strwidth(line))
-- 			table.insert(lines, Menu.item(line, { value = item, idx = i }))
-- 		end
--
-- 		if not config.size then
-- 			line_width = math.max(line_width, config.min_width)
-- 			local height = math.max(#lines, config.min_height)
-- 			config.size = {
-- 				width = line_width,
-- 				height = height,
-- 			}
-- 		end
--
-- 		local callback
-- 		callback = function(...)
-- 			on_choice(...)
-- 			-- Prevent double-calls
-- 			callback = function() end
-- 		end
--
-- 		local border = vim.deepcopy(config.border)
-- 		border.text = {
-- 			top = opts.prompt,
-- 			top_align = 'center',
-- 		}
-- 		local menu = Menu({
-- 			position = config.position,
-- 			size = config.size,
-- 			relative = config.relative,
-- 			border = border,
-- 			buf_options = config.buf_options,
-- 			win_options = config.win_options,
-- 			enter = true,
-- 		}, {
-- 			lines = lines,
-- 			max_width = config.max_width,
-- 			max_height = config.max_height,
-- 			keymap = {
-- 				focus_next = { 'j', '<Down>', '<Tab>' },
-- 				focus_prev = { 'k', '<Up>', '<S-Tab>' },
-- 				close = { '<Esc>', '<C-c>' },
-- 				submit = { '<CR>' },
-- 			},
-- 			on_close = function()
-- 				vim.schedule(function()
-- 					callback(nil, nil)
-- 				end)
-- 			end,
-- 			on_submit = function(item)
-- 				callback(item.value, item.idx)
-- 			end,
-- 		})
--
-- 		menu:mount()
--
-- 		menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
-- 	end
-- end

return M
