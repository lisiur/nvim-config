-- Editor: editing enhancements, file management, search, and navigation

------------------
-- Guess indent --
------------------
vim.pack.add {
  'https://github.com/NMAC427/guess-indent.nvim',
}
require('guess-indent').setup {}

-------------------
-- Surround --
-------------------
vim.pack.add {
  {
    src = 'https://github.com/kylechui/nvim-surround',
    version = vim.version.range '4.x',
  },
}

----------
-- Jump --
----------
vim.pack.add {
  'https://github.com/folke/flash.nvim',
}
require('flash').setup {
  modes = {
    char = { enabled = false },
  },
}
vim.keymap.set('n', 'gw', function()
  require('flash').jump()
end, { desc = 'Jump' })

-------------
-- Format --
-------------
vim.pack.add {
  { src = 'https://github.com/stevearc/conform.nvim' },
}
require('conform').setup {
  default_format_opts = {
    lsp_format = 'fallback',
  },

  formatters_by_ft = {},
}
-- stylua: ignore start
vim.keymap.set('n', '<leader>l', function() require('conform').format { async = true } end, { desc = 'Format buffer' })
-- stylua: ignore end

------------------------
-- Global replacement --
------------------------
vim.pack.add {
  'https://github.com/MagicDuck/grug-far.nvim',
}
require('grug-far').setup {}

--------------
-- comments --
--------------
vim.pack.add {
  { src = 'https://github.com/folke/ts-comments.nvim' },
}
---@diagnostic disable-next-line: missing-fields
require('ts-comments').setup {}

-- Highlight TODO/NOTE/WARN etc.
vim.pack.add {
  { src = 'https://github.com/folke/todo-comments.nvim' },
}
require('todo-comments').setup {
  signs = false,
}

---------
-- fzf --
---------
vim.pack.add { 'https://github.com/ibhagwan/fzf-lua' }
local actions = require 'fzf-lua.actions'
require('fzf-lua').setup {
  ui_select = true,
  files = {
    header = false,
  },
  grep = {
    header = false,
    actions = {
      ['ctrl-r'] = { actions.grep_lgrep },
    },
  },
}
local FzfLua = require 'fzf-lua'
-- stylua: ignore start
-- Buffers and files
vim.keymap.set({'n'}, "<leader>b", function() FzfLua.buffers() end, {desc = "Buffers" })
vim.keymap.set({'n'}, "<leader>f", function() FzfLua.files({
  hidden = true,
}) end, {desc = "Find Files" })
vim.keymap.set({'n'}, "<leader>q", function() FzfLua.quickfix() end, {desc = "Quickfix" })

-- Search
vim.keymap.set({'n'}, "<leader>/", function() FzfLua.live_grep_native() end, {desc = "Live grep" })
vim.keymap.set({'v'}, "<leader>/", function() FzfLua.grep_visual() end, {desc = "Grep visual" })
vim.keymap.set({'n', 'v'}, "<leader>*", function() FzfLua.grep_cword() end, {desc = "Search word under cursor" })
vim.keymap.set({'n'}, "<leader>:", function() FzfLua.commands() end, {desc = "Commands" })

-- Git
vim.keymap.set({'n'}, "<leader>gb", function() FzfLua.git_branches() end, {desc = "Git Branches" })
vim.keymap.set({'n'}, "<leader>gl", function() FzfLua.git_commits() end, {desc = "Git Log" })
vim.keymap.set({'n'}, "<leader>gs", function() FzfLua.git_status() end, {desc = "Git Status" })
vim.keymap.set({'n'}, "<leader>gd", function() FzfLua.git_diff() end, {desc = "Git Diff (Hunks)" })
vim.keymap.set({'n'}, "<leader>gf", function() FzfLua.git_bcommits() end, {desc = "Git Log File" })

-- LSP
vim.keymap.set({'n'}, "<leader>d", function() FzfLua.lsp_document_diagnostics() end, {desc = "Diagnostics" })
vim.keymap.set({'n'}, "<leader>D", function() FzfLua.lsp_workspace_diagnostics() end, {desc = "Buffer Diagnostics" })
vim.keymap.set({'n'}, "<leader>a", function() FzfLua.lsp_code_actions() end, {desc = "Code actions" })
vim.keymap.set({'n'}, "gd", function() FzfLua.lsp_definitions() end, {desc = "Goto Definition" })
vim.keymap.set({'n'}, "gD", function() FzfLua.lsp_declarations() end, {desc = "Goto Declaration" })
vim.keymap.set({'n'}, "gr", function() FzfLua.lsp_references() end, {nowait = true, desc = "References" })
vim.keymap.set({'n'}, "gi", function() FzfLua.lsp_implementations() end, {desc = "Goto Implementation" })
vim.keymap.set({'n'}, "gy", function() FzfLua.lsp_typedefs() end, {desc = "Goto T[y]pe Definition" })
vim.keymap.set({'n'}, "gRi", function() FzfLua.lsp_incoming_calls() end, {desc = "C[a]lls Incoming" })
vim.keymap.set({'n'}, "gRo", function() FzfLua.lsp_outgoing_calls() end, {desc = "C[a]lls Outgoing" })
vim.keymap.set({'n'}, "<leader>s", function() FzfLua.lsp_document_symbols() end, {desc = "LSP Symbols" })
vim.keymap.set({'n'}, "<leader>S", function() FzfLua.lsp_workspace_symbols() end, {desc = "LSP Workspace Symbols" })

-- Misc
vim.keymap.set({'n'}, '<leader>"', function() FzfLua.registers() end, {desc = "Registers" })
vim.keymap.set({'n'}, "<leader>j", function() FzfLua.jumps() end, {desc = "Jumps" })
vim.keymap.set({'n'}, "<leader>'", function() FzfLua.resume() end, {desc = "Resume" })
-- stylua: ignore end

------------------
-- File manager --
------------------
vim.pack.add {
  'https://github.com/mikavilpas/yazi.nvim',
}
require('yazi').setup {
  -- open_for_directories = true,
  keymaps = {
    grep_in_directory = '<c-s>',
    replace_in_directory = '<c-a>',
  },
}

-- stylua: ignore start
vim.keymap.set('n', '<leader>e', function() require('yazi').yazi() end, { desc = 'Open Yazi in current file directory' })
vim.keymap.set('n', '<leader>E', function() require('yazi').yazi({}, vim.fn.getcwd()) end, { desc = 'Open Yazi in current working directory' })
-- stylua: ignore end
