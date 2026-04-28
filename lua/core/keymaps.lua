--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Keep cursor last position after yank
vim.keymap.set('v', 'y', 'myy`y')

-- Keep selection after indent
vim.keymap.set({ 'v' }, '<', '<gv', { desc = 'Indent left and keep selection' })
vim.keymap.set({ 'v' }, '>', '>gv', { desc = 'Indent right and keep selection' })

-- Copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to system clipboard' })
-- Select pasted lines after 'p'
vim.keymap.set("n", "p", "p`[v`]", { desc = "Paste and select lines" })
-- Select pasted lines after 'P'
vim.keymap.set("n", "P", "P`[v`]", { desc = "Paste and select lines (before cursor)" })
-- Paste from system clipboard
vim.keymap.set({ 'n' }, '<leader>p', [["+p]], { desc = 'Paste from system clipboard' })

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

-- Open lazygit
vim.keymap.set('n', '<leader>V', function()
  local buf = vim.api.nvim_create_buf(false, true)

  -- Window layout math (same as before)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Using jobstart with the term option
  -- This creates a terminal instance within the buffer
  vim.fn.jobstart({ 'lazygit' }, {
    term = true, -- This is the key: it opens the process in a terminal
    on_exit = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  vim.cmd 'startinsert'
end, { desc = 'Open Lazygit in Float' })
