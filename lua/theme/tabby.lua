local theme = {
	fill = 'TabLineFill',
	-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
	head = 'TabLine',
	current_tab = 'TabLineSel',
	tab = 'TabLine',
	win = 'TabLine',
	tail = 'TabLine',
}
require('tabby.tabline').set(function(line)
	return {
		line.tabs().foreach(function(tab)
			local hl = 'TabLineSel' or theme.tab
			return {
				line.sep('', hl, 'TablineFill'),
				tab.is_current() and '' or '󰆣',
				tab.number(),
				tab.name(),
				tab.close_btn(''),
				line.sep('', hl, 'TablineFill'),
				hl = hl,
				margin = ' ',
			}
		end),
		line.spacer(),
		line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			return {
				line.sep('', 'TabLineSel', 'TablineFill'),
				win.is_current() and '' or '',
				win.buf_name(),
				line.sep('', 'TabLineSel', 'TablineFill'),
				hl = 'TabLineSel',
				margin = ' ',
			}
		end),
		{
			{ '  ', hl = 'TablLineFill' },
		},
		hl = 'TablineFill',
	}
end)
