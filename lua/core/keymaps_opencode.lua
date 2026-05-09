local zellij = require 'core.utils.zellij'
local opencode = zellij.create { cmd = 'opencode' }

vim.keymap.set({ 'n', 'v' }, '<leader>oc', opencode.toggle, { desc = 'Toggle opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>ox', opencode.close, { desc = 'Close opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>oo', opencode.focus, { desc = 'Focus opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>or', opencode.send_reference, { desc = 'Send reference to opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>oi', opencode.send_instruction, { desc = 'Send instruction to opencode' })
