---------------
-- Telescope --
---------------
vim.pack.add {
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
}
require('telescope').setup {
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    file_ignore_patterns = {
      '%.git/',
      'node_modules',
      'target',
      'dist',
    },
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
      },
    },
    mappings = {
      i = {
        ['<C-s>'] = require('telescope.actions').to_fuzzy_refine,
      },
    },
  },
}

local function enhanced(callback)
  return function()
    if _G.MiniFiles ~= nil and _G.MiniFiles.close ~= nil then
      _G.MiniFiles.close()
    end
    if callback then
      callback()
    end
  end
end

local builtin = require 'telescope.builtin'

-- stylua: ignore start
vim.keymap.set('n', '<leader>f', enhanced(builtin.find_files), { desc = 'Find files' })
vim.keymap.set('n', '<leader>/', enhanced(builtin.live_grep), { desc = 'Search content' })
vim.keymap.set('v', '<leader>/', enhanced(builtin.grep_string), { desc = 'Search selection' })
vim.keymap.set('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Buffer Diagnostics' })
vim.keymap.set('n', '<leader>D', enhanced(builtin.diagnostics), { desc = 'Workspace diagnostics' })
vim.keymap.set('n', '<leader>b', enhanced(builtin.buffers), { desc = 'Search buffers' })
vim.keymap.set('n', '<leader>\'', enhanced(builtin.resume), { desc = 'Open last picker' })
vim.keymap.set('n', '<leader>g', enhanced(builtin.git_status), { desc = 'Git status' })
-- stylua: ignore end

------------
-- Notify --
------------
vim.pack.add {
  'https://github.com/rcarriga/nvim-notify',
}

require('notify').setup {
  merge_duplicates = true,
}

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
vim.keymap.set({ 'n', 'x' }, '<leader>or', function() return require('opencode').operator('@this ') end, { desc = 'Add reference to opencode', expr = true })
-- vim.keymap.set('n', '<S-C-u>', function() require('opencode').command 'session.half.page.up' end, { desc = 'Scroll opencode up' })
-- vim.keymap.set('n', '<S-C-d>', function() require('opencode').command 'session.half.page.down' end, { desc = 'Scroll opencode down' })
-- stylua: ignore end
