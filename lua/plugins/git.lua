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

--------------
-- LazyGit --
--------------
vim.pack.add {
  'https://github.com/kdheepak/lazygit.nvim',
}
-- stylua: ignore start
vim.keymap.set('n', '<leader>V', "<cmd>LazyGit<cr>", { desc = 'LazyGit' })
-- stylua: ignore end
