-- LSP: language server management, keymaps, server configs, and diagnostics display

---------
-- LSP --
---------
vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
}
require('mason').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end


    -- stylua: ignore start
    map('<leader>r', vim.lsp.buf.rename, '[R]ename')
    map('K', function() vim.lsp.buf.hover { border = 'rounded' } end, 'Show LSP documentation')
    map('<leader>k', function()
      vim.lsp.buf.hover({ border = 'rounded' })
      -- vim.schedule(function()
      --     vim.lsp.buf.hover({ border = 'rounded' })
      -- end)
    end, "Show LSP documentation")
    -- stylua: ignore end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

local servers = {
  rust_analyzer = {},
  ts_ls = {},

  stylua = {},
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    settings = {
      Lua = {
        format = { enable = false },
      },
    },
  },
}

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-----------------------
-- Inline diagnostic --
-----------------------
vim.pack.add {
  'https://github.com/rachartier/tiny-inline-diagnostic.nvim',
}
require('tiny-inline-diagnostic').setup {
  preset = 'classic',
}
