# AGENTS.md

## Plugin Manager

Uses **Neovim's built-in `vim.pack.add`** (requires Neovim 0.12+). Not lazy.nvim, packer, or any external plugin manager. Lock file is `nvim-pack-lock.json`.

## Structure

- `init.lua` — entry point: `require "core"` then `require 'plugins'`
- `lua/core/` — options, keymaps, autocmds (loaded before plugins)
- `lua/plugins/init.lua` — loads plugin modules in dependency order:
  `dep` → `ui` → `editor` → `treesitter` → `cmp` → `lsp` → `git` → `ai` → `enhanced`
- `lua/plugins/archived.lua` — **not loaded**; dead code kept for reference only

## Style (from `.stylua.toml`)

- 2-space indent, spaces not tabs
- Single quotes preferred, no call parentheses
- 160 column width
- Use `-- stylua: ignore start` / `-- stylua: ignore end` blocks around keymaps that must stay on one line

## Plugin File Pattern

Each plugin section follows:

```lua
-- Title --
vim.pack.add { 'https://github.com/owner/repo' }
require('plugin').setup { ... }
```

Sections separated by comment banners with dashes.

## Gotchas

- **LSP uses Neovim 0.11+ native API** (`vim.lsp.config` / `vim.lsp.enable`), not `lspconfig.setup()`. Servers are defined in `lsp.lua` via `vim.lsp.config(name, opts)` then `vim.lsp.enable(name)`.
- **LSP navigation keymaps** (`gd`, `gr`, `gi`, `gy`, `gD`, `gRi`, `gRo`, `<leader>s`, `<leader>S`, `<leader>d`, `<leader>D`, `<leader>a`) are defined in `editor.lua` via fzf-lua — NOT in the `LspAttach` callback in `lsp.lua`. Only `<leader>r`, `<leader>k`, and `<leader>th` are in LspAttach.
- **blink.cmp** calls `cmp.build():wait(60000)` in `cmp.lua` — it blocks to build the Rust fuzzy matcher on first load. Uses `preset = 'none'` with fully custom key bindings.
- **Lua LS formatting is disabled** in `lsp.lua` via both `documentFormattingProvider = false` in `on_init` and `format = { enable = false }` in settings; stylua via conform handles formatting.
- **conform.nvim** has an empty `formatters_by_ft` table in `editor.lua` — formatters are expected to be configured per-project, not globally.
- **codediff.nvim and neogit** in `git.lua` are lazy-loaded via stub `:CodeDiff` / `:Neogit` commands that delete themselves, `packadd`, then re-invoke.
- **Netrw is disabled** (`vim.g.loaded_netrw = 1` in `options.lua`); yazi handles file management.
- **fzf-lua** is registered as the `vim.ui.select` handler (`ui_select = true`), so all `vim.ui.select` calls route through fzf.
- **Treesitter folding** uses `foldlevel = 99` / `foldlevelstart = 99` — all folds are open by default.
- **Lock file contains stale entries** from previous plugins (catppuccin, telescope, nvim-cmp, oil, noice, etc.) that are no longer referenced in any plugin module.
- **opencode integration** in `ai.lua` enables `vim.o.autoread = true` so Neovim auto-reloads files changed externally.
