# AGENTS.md

## Plugin Manager

Uses **Neovim's built-in `vim.pack.add`** (requires Neovim 0.11+). Not lazy.nvim, packer, or any external plugin manager. Lock file is `nvim-pack-lock.json`.

## Structure

- `init.lua` — entry point: options, keymaps, then `require("plugins")` and `require("utils")`
- `lua/plugins/init.lua` — loads plugin modules in dependency order:
  `dep` → `ui` → `editor` → `treesitter` → `cmp` → `lsp` → `git` → `enhanced`
- `lua/plugins/deprecated.lua` — **not loaded**; dead code kept for reference only
- `lua/utils/` — utility modules (lazygit integration, etc.)

## Style (from `.stylua.toml`)

- 2-space indent, spaces not tabs
- Single quotes preferred, no call parentheses
- 160 column width
- Use `-- stylua: ignore start` / `-- stylua: ignore end` blocks around keymaps that must stay on one line

## Key Conventions

- Leader: `<Space>`
- `<leader>e`/`<leader>E` — yazi (current dir / cwd)
- `<leader>f` — fzf files, `<leader>b` — buffers, `<leader>/` — live grep
- `<leader>l` — format buffer (conform.nvim)
- `<leader>V` — lazygit in floating window
- `<leader>r` — LSP rename, `<leader>k` — LSP hover
- `<leader>B` — git line blame, `]g`/`[g` — next/prev git hunk
- `<leader>oa`/`os`/`oc` — opencode integration
- `H`/`L` — buffer prev/next (not window nav)
- `gw` — flash jump
- `ge` — goto last line (remapped from `G`)
- Netrw is disabled; yazi and oil handle file management

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
- **blink.cmp** calls `cmp.build():wait(60000)` in `cmp.lua` — it blocks to build the Rust fuzzy matcher on first load.
- **Lua LS formatting is disabled** in `lsp.lua` (`format = { enable = false }`); stylua via conform handles it.
