local zellij = require 'core.utils.zellij'
local opencode = zellij.create { cmd = 'opencode' }

-- stylua: ignore start
vim.keymap.set({ 'n', 'v' }, '<leader>oc', opencode.toggle, { desc = 'Toggle opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>ox', opencode.close, { desc = 'Close opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>oo', opencode.focus, { desc = 'Focus opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>ori', function() opencode.send_reference('@this') end, { desc = 'Send reference(cursor) to opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>orb', function() opencode.send_reference('@buffer') end, { desc = 'Send reference(buffer) to opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>orB', function() opencode.send_reference('@buffers') end, { desc = 'Send reference(buffers) to opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>ord', function() opencode.send_reference('@diagnostics') end, { desc = 'Send reference(diagnostics) to opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>oii', function() opencode.send_instruction('@this') end, { desc = 'Send instruction(cursor) to opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>oib', function() opencode.send_instruction('@buffer') end, { desc = 'Send instruction(buffer) to opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>oiB', function() opencode.send_instruction('@buffers') end, { desc = 'Send instruction(buffers) to opencode' })
vim.keymap.set({ 'n', 'v' }, '<leader>oid', function() opencode.send_instruction('@diagnostics') end, { desc = 'Send instruction(diagnostics) to opencode' })
-- stylua: ignore end
