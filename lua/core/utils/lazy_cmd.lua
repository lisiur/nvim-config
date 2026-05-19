local M = {}

function M.lazy_cmd(cmd, pkg)
  vim.api.nvim_create_user_command(cmd, function(opts)
    vim.api.nvim_del_user_command(cmd)
    vim.cmd('packadd ' .. pkg)
    local ok = pcall(vim.api.nvim_cmd, { cmd = cmd, args = opts.fargs, bang = opts.bang }, {})
    if not ok then
      print('Plugin loaded but command ' .. cmd .. ' failed')
    end
  end, { nargs = '*', bang = true })
end

return M
