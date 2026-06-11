-------------------
-- CodeCompanion --
-------------------
vim.pack.add {
  'https://github.com/olimorris/codecompanion.nvim',
}
require('codecompanion').setup {
  interactions = {
    chat = {
      adapter = 'opencode',
    },
  },
}

-- -- stylua: ignore start
-- vim.keymap.set({ 'n', 'v' }, '<leader>oc', "<cmd>CodeCompanionToggle<cr>", { desc = 'Toggle CodeCompanion' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>ox', opencode.close, { desc = 'Close opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>oo', opencode.focus, { desc = 'Focus opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>on', function() opencode.send_keys { { key = 'Ctrl p' }, { sleep = 100 }, { chars = 'new session' }, { key = 'Enter' } } end, { desc = 'New opencode session' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>ori', function() opencode.send_reference('@this') end, { desc = 'Send reference(cursor) to opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>orb', function() opencode.send_reference('@buffer') end, { desc = 'Send reference(buffer) to opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>orB', function() opencode.send_reference('@buffers') end, { desc = 'Send reference(buffers) to opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>ord', function() opencode.send_reference('@diagnostic') end, { desc = 'Send reference(diagnostic) to opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>orD', function() opencode.send_reference('@diagnostics') end, { desc = 'Send reference(diagnostics) to opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>oii', function() opencode.send_instruction('@this') end, { desc = 'Send instruction(cursor) to opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>oib', function() opencode.send_instruction('@buffer') end, { desc = 'Send instruction(buffer) to opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>oiB', function() opencode.send_instruction('@buffers') end, { desc = 'Send instruction(buffers) to opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>oid', function() opencode.send_instruction('@diagnostic') end, { desc = 'Send instruction(diagnostic) to opencode' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>oiD', function() opencode.send_instruction('@diagnostics') end, { desc = 'Send instruction(diagnostics) to opencode' })
-- stylua: ignore end

--------------
-- Sidekick --
--------------
vim.pack.add {
  'https://github.com/folke/sidekick.nvim',
}
require('sidekick').setup {
  nes = { enabled = false },
  cli = {
    win = {
      split = {
        width = 130
      }
    },
    mux = {
      backend = 'zellij',
      enabled = true,
    },
    picker = 'fzf-lua',
    tools = {
      opencode = {
        keys = {
          esc = { '<Esc>', '<Esc>' },
        },
      },
    },
  },
}
-- stylua: ignore start
vim.keymap.set({ 'n', 't', 'i', 'x' }, '<c-.>', function() require('sidekick.cli').focus() end, { desc = 'Sidekick Focus' })
vim.keymap.set({ 'n' }, '<leader>ot', function() require('sidekick.cli').toggle({name = 'opencode', focus = true}) end, { desc = 'Sidekick Toggle CLI' })
vim.keymap.set({ 'n' }, '<leader>oc', function() require('sidekick.cli').close() end, { desc = 'Detach a CLI Session' })
vim.keymap.set({ 'n', 'x' }, '<leader>oi', function() require('sidekick.cli').send({msg = '{this}'}) end, { desc = 'Send This' })
vim.keymap.set({ 'n' }, '<leader>of', function() require('sidekick.cli').send({msg = '{file}'}) end, { desc = 'Send File' })
vim.keymap.set({ 'n', 'x' }, '<leader>op', function() require('sidekick.cli').prompt() end, { desc = 'Sidekick Select Prompt' })
-- stylua: ignore end
