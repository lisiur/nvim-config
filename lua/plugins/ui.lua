-- UI: theme, icons, statusline, tabline, cursor effects, and visual rendering

---------------
-- Tokyonight --
---------------
vim.pack.add {
  { src = 'https://github.com/folke/tokyonight.nvim' },
}
---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false },
  },
  on_colors = function(color)
    color.bg = '#171b21'
    color.fg = '#D4D8D9'
    color.red = '#fc618d'
    color.orange = '#fd9353'
    color.yellow = '#F9DD65'
    color.green = '#76AF6D'
    color.blue = '#82A1F1'
    color.purple = '#948ae3'
    color.cyan = '#7CD1E3'
  end,
  on_highlights = function(hl, c)
    hl.WinSeparator = { fg = c.comment }
    hl.Keyword = { fg = c.red, italic = true }
    hl.DiagnosticUnnecessary = { fg = '#7E7B81' }
    hl.Function = { fg = c.green }
    hl.Constant = { fg = c.orange }
    hl.Special = { fg = c.fg }
    hl.String = { fg = c.yellow }
    hl.Statement = { fg = c.red }
    hl.Type = { fg = c.cyan }

    hl['@keyword'] = { fg = c.red }
    hl['@keyword.function'] = { fg = c.red }
    hl['@variable'] = { fg = c.fg }
    hl['@variable.builtin'] = { fg = c.cyan }
    hl['@type.builtin'] = { fg = c.cyan }
    hl['@lsp.type.interface'] = { fg = c.green }
    hl['@lsp.type.variable'] = { fg = c.fg }
  end,
}
vim.cmd.colorscheme 'tokyonight-night'

------------
-- Snacks --
------------
vim.pack.add {
  'https://github.com/folke/snacks.nvim',
}
require('snacks').setup {
  -- refuse to open big file
  bigfile = {},
  -- quick open one file
  quickfile = {},
  -- indent line
  indent = {},
  -- vim.ui.input
  input = {},

  styles = {
    input = {
      relative = 'cursor',
    },
  },
}

-----------
-- Icons --
-----------
vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
}
require('nvim-web-devicons').setup {}

vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
}
require('mini.icons').setup {}

------------
-- Cursor --
------------
vim.pack.add {
  'https://github.com/sphamba/smear-cursor.nvim',
}
require('smear_cursor').setup {
  stiffness = 0.8,                      -- 0.6      [0, 1]
  trailing_stiffness = 0.6,             -- 0.45     [0, 1]
  stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
  trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
  damping = 0.95,                       -- 0.85     [0, 1]
  damping_insert_mode = 0.95,           -- 0.9      [0, 1]
  distance_stop_animating = 0.5,        -- 0.1      > 0
}

----------------
-- Statusline --
----------------
vim.pack.add {
  'https://github.com/nvim-lualine/lualine.nvim',
}
require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
    disabled_filetypes = {
      winbar = { 'sidekick_terminal' },
    },
  },
  winbar = {
    lualine_c = {
      { 'filename', path = 1 },
    },
    lualine_x = {
      { 'lsp_status' },
    },
  },
  inactive_winbar = {
    lualine_a = {
      { 'filename', path = 1 },
    },
    lualine_x = {
      { 'lsp_status' },
    },
  },
}

-------------
-- Tab bar --
-------------
vim.pack.add {
  'https://github.com/romgrk/barbar.nvim',
}
require('barbar').setup {
  exclude_ft = { 'sidekick_terminal' },
  no_name_title = '',
}

-- stylua: ignore start
vim.keymap.set('n', 'H', '<Cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', 'L', '<Cmd>BufferNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { desc = 'Move buffer previous' })
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { desc = 'Move buffer next' })
-- stylua: ignore end

------------
-- Notify --
------------
vim.pack.add {
  'https://github.com/j-hui/fidget.nvim',
}
require('fidget').setup {
  notification = {
    override_vim_notify = true,
  },
}
