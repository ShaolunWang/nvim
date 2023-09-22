vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


vim.cmd [[
augroup spring_override
	autocmd!
	  autocmd Colorscheme spring-night hi LineNr ctermfg=231 ctermbg=231 guifg=#8d9eb2 guibg=#132132
	  autocmd Colorscheme spring-night hi SignColumn ctermfg=None ctermbg=None guifg=None guibg=None
augroup END
]]

vim.api.nvim_create_autocmd('TextYankPost',
{
  group = vim.api.nvim_create_augroup('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 400 }
  end,
})

-- Function to read and go to tag definition
function goto_tag()
  local word = vim.fn.expand('<cword>') -- Get word under cursor
  if word == "" then return end

  -- Use readtags to find the corresponding tag entry
  local handle = io.popen('readtags -e -n -l -t tags -s ' .. word)
  local result = handle:read("*a")
  handle:close()

  -- Extract the filename and ex_cmd (Ex command) fields
  for line in result:gmatch("[^\r\n]+") do
    local fields = {}
    for field in line:gmatch("([^\t]+)") do
      table.insert(fields, field)
    end

    if #fields >= 4 then
      local tag, filename, ex_cmd = fields[1], fields[2], fields[4]
      if filename and ex_cmd then
        -- Navigate to file and execute Ex command to go to line
        vim.cmd("e " .. filename)
        vim.cmd("silent! " .. ex_cmd)
        return
      end
    end
  end
  print("Tag not found")
end

-- Map <C-]> to execute the function
vim.api.nvim_set_keymap('n', '<C-]>', [[<Cmd>lua goto_tag()<CR>]], { noremap = true, silent = true })
