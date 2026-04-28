---------------------
-- Render markdown --
---------------------
vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}
require('render-markdown').setup {
  preset = 'obsidian',
  heading = {
    enabled = true,
    icons = { '󰉫  ', '󰉬  ', '󰉭  ', '󰉮  ', '󰉯  ', '󰉰  ' },
  },
  code = {
    position = 'left',
    border = 'thin',
    style = 'language',
  },
  sign = {
    enabled = false,
  },
  anti_conceal = { enabled = false },
  file_types = { 'markdown' },
}
-- 为 markdown 缓冲区创建快捷键
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.keymap.set('n', '<leader>mr', '<cmd>RenderMarkdown buf_toggle<cr>', {
      buffer = true, -- 只在当前缓冲区生效
      desc = 'Toggle markdown rendering',
      noremap = true,
      silent = true,
    })
  end,
})

---------------
-- Which key --
---------------
vim.pack.add {
  'https://github.com/folke/which-key.nvim',
}

require('which-key').setup {
  preset = 'helix',
  -- triggers = {
  --   { '<leader>', mode = { 'n', 'v' } },
  --   { 'g', mode = { 'n', 'v' } },
  --   { 'z', mode = { 'n', 'v' } },
  --   { 'd', mode = { 'n' } },
  -- },
}
