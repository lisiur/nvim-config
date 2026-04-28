-- Treesitter: syntax highlighting, parsing, and comment highlighting

---------------
-- Treesitter --
---------------
vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
}
require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath 'data' .. '/site',
}
require('nvim-treesitter').install { 'rust', 'javascript', 'typescript', 'tsx', 'zig', 'lua', 'vue', 'css', 'html' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'vue', 'typescript', 'tsx', 'rust', 'css', 'javascript' },
  callback = function()
    vim.treesitter.start()
  end,
})

