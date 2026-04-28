-- Autocompletion: completion engine, snippet sources, and signature help

--------------------
-- Autocompletion --
--------------------
vim.pack.add {
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/saghen/blink.lib' },
  { src = 'https://github.com/saghen/blink.cmp' },
}
local cmp = require 'blink.cmp'
cmp.build():wait(60000)
cmp.setup {
  completion = {
    keyword = { range = 'full' },
    list = {
      selection = {
        preselect = false,
      },
    },
  },
  cmdline = {
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
    },
  },
  keymap = {
    preset = 'none',
    ['<C-x>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-c>'] = { 'cancel', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      snippets = {
        opts = {
          friendly_snippets = true,
        },
      },
      buffer = {
        opts = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
    },
  },

  fuzzy = { implementation = 'prefer_rust_with_warning' },

  signature = { enabled = true },
}
