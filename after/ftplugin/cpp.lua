vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.keymap.set('n', ',i', ':ClangdSwitchSourceHeader<cr>', { desc = 'switch between h/cpp (clang)', noremap = true })
--vim.keymap.set('n', ',s', ':Ouroboros<cr>', { desc = 'switch between h/cpp (Ouroboros)', noremap = true })
vim.cmd([[xnoremap <buffer> ,w <esc>`>a)<c-o>`<static_cast<>(<left><left>]])
