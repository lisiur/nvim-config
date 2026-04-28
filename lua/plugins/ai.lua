--------------
-- Opencode --
--------------
vim.pack.add {
  'https://github.com/nickjvandyke/opencode.nvim',
}
vim.o.autoread = true -- auto reload files changed outside neovim (e.g. by opencode)
-- stylua: ignore start
vim.keymap.set({ 'n', 'x' }, '<leader>oc', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })
vim.keymap.set({ 'n', 'x' }, '<leader>oo', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode…' })
vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() require('opencode').select() end, { desc = 'Execute opencode action…' })
vim.keymap.set({ 'n', 'x' }, '<leader>or', function() return require('opencode').operator '@this ' end, { desc = 'Add reference to opencode', expr = true })
-- vim.keymap.set('n', '<S-C-u>', function() require('opencode').command 'session.half.page.up' end, { desc = 'Scroll opencode up' })
-- vim.keymap.set('n', '<S-C-d>', function() require('opencode').command 'session.half.page.down' end, { desc = 'Scroll opencode down' })
-- stylua: ignore end

