-- Cleanup initial project-named buffer on first file open
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Cleanup initial project-named buffer on first file open',
  once = true,
  callback = function()
    vim.schedule(function()
      local bufs = vim.api.nvim_list_bufs()
      for _, bufnr in ipairs(bufs) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        -- Check if it's a directory and hasn't been modified
        if vim.fn.isdirectory(name) == 1 and not vim.api.nvim_get_option_value('modified', { buf = bufnr }) then
          -- Use a safer delete command; 'bdelete' is standard
          -- If using Barbar, 'BufferClose' works but verify the buffer exists
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.cmd('bdelete ' .. bufnr)
          end
        end
      end
    end)
  end,
})

