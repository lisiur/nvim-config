-- Git: hunk navigation, blame, and diff integration in the sign column

--------------
-- Gitsigns --
--------------
vim.pack.add {
  'https://github.com/lewis6991/gitsigns.nvim',
}
require('gitsigns').setup {
  preview_config = {
    border = 'rounded',
  },
  on_attach = function(bufnr)
    local gitsigns = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- stylua: ignore start
    map('n', ']g', function() gitsigns.nav_hunk 'next' end, { desc = 'Next Git hunk' })
    map('n', '[g', function() gitsigns.nav_hunk 'prev' end, { desc = 'Prev Git hunk' })
    map('n', '<leader>B', function() gitsigns.blame_line { full = true } end, { desc = 'Show line blame' })
    -- stylua: ignore end
  end,
}

vim.pack.add {
  'https://github.com/esmuellert/codediff.nvim',
}
vim.api.nvim_create_user_command('CodeDiff', function(opts)
  -- 1. 立即删除这个存根命令，避免递归冲突
  vim.api.nvim_del_user_command 'CodeDiff'

  -- 2. 手动加载插件 (:packadd)
  vim.cmd 'packadd codediff.nvim'

  -- 3. 转发执行原本的命令及其参数
  -- 使用 pcall 是为了防止插件加载后若没定义该命令导致报错
  local success, _ = pcall(vim.api.nvim_cmd, {
    cmd = 'CodeDiff',
    args = opts.fargs,
    bang = opts.bang,
  }, {})

  if not success then
    print '插件加载成功，但命令 CodeDiff 未能执行'
  end
end, {
  nargs = '*', -- 允许接受参数
  bang = true, -- 允许 CodeDiff! 这种形式
})

vim.pack.add {
  'https://github.com/NeogitOrg/neogit',
}
vim.api.nvim_create_user_command('Neogit', function(opts)
  vim.api.nvim_del_user_command 'Neogit'

  vim.cmd 'packadd neogit'

  local success, _ = pcall(vim.api.nvim_cmd, {
    cmd = 'Neogit',
    args = opts.fargs,
    bang = opts.bang,
  }, {})

  if not success then
    print '插件加载成功，但命令 Neogit 未能执行'
  end
end, {
  nargs = '*', -- 允许接受参数
  bang = true, -- 允许 CodeDiff! 这种形式
})
