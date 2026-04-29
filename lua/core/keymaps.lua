--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keep cursor stay last position after yank
vim.keymap.set('v', 'y', 'myy`y')

-- Keep selection after indent
vim.keymap.set({ 'v' }, '<', '<gv', { desc = 'Indent left and keep selection' })
vim.keymap.set({ 'v' }, '>', '>gv', { desc = 'Indent right and keep selection' })

-- Copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to system clipboard' })
-- Select last pasted
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted" })
-- Paste from system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]], { desc = 'Paste below (system clipboard)' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+P]], { desc = 'Paste above (system clipboard)' })

-- Quick move
vim.keymap.set({ 'n', 'v' }, 'gg', 'gg', { desc = 'Goto first line' })
vim.keymap.set({ 'n', 'v' }, 'ge', 'G', { desc = 'Goto last line' })
vim.keymap.set({ 'n', 'v' }, 'gh', '^', { desc = 'Goto line start' })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'Goto line end' })

-- Esc to switch mode to normal from terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

-- Copy diagnostic to system clipboard
vim.keymap.set('n', '<leader><leader>y', function()
  local diags = vim.diagnostic.get(0, { lnum = vim.fn.line '.' - 1 })
  if #diags > 0 then
    -- Copies the message of the first diagnostic on the current line to the + register (clipboard)
    vim.fn.setreg('+', diags[1].message)
    vim.notify 'Diagnostic copied to clipboard!'
  end
end, { desc = 'Copy diagnostic message' })


