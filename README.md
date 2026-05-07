# Neovim Configuration

Personal Neovim configuration built on **Neovim 0.12+** using the built-in `vim.pack.add` plugin manager.

## Requirements

- Neovim 0.12+
- A [Nerd Font](https://www.nerdfonts.com/) installed and selected in your terminal
- [fzf](https://github.com/junegunn/fzf) (for fzf-lua)
- [ripgrep](https://github.com/burntsushi/ripgrep) (for fzf-lua)
- [yazi](https://github.com/sxyazi/yazi) (for yazi.nvim)

## Structure

```
.
├── init.lua                    # Entry point: loads core and plugins
├── lua/
│   ├── core/
│   │   ├── init.lua            # Loads options, keymaps, autocmds
│   │   ├── options.lua         # Editor options, folding, leader key
│   │   ├── keymaps.lua         # Global keymaps (clipboard, navigation)
│   │   └── autocmds.lua        # Autocommands (directory buffer cleanup, highlight on yank)
│   └── plugins/
│       ├── init.lua            # Loads modules in dependency order
│       ├── dep.lua             # Shared dependencies (plenary)
│       ├── ui.lua              # Theme, statusline, icons, cursor effects, notifications
│       ├── editor.lua          # Editing, file management, search, navigation, formatting
│       ├── treesitter.lua      # Syntax highlighting
│       ├── cmp.lua             # Autocompletion (blink.cmp)
│       ├── lsp.lua             # LSP servers, diagnostics
│       ├── git.lua             # Git integration (gitsigns, codediff, neogit)
│       ├── ai.lua              # AI integration (opencode)
│       ├── enhanced.lua        # Markdown rendering, which-key
│       └── archived.lua        # Not loaded; kept for reference only
├── .stylua.toml                # StyLua formatting config
└── nvim-pack-lock.json         # Plugin lock file
```

## Plugins

| Category | Plugin | Description |
|----------|--------|-------------|
| **Theme** | [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Customized Tokyonight Night colorscheme |
| **UI** | [snacks.nvim](https://github.com/folke/snacks.nvim) | Big file protection, indent lines, quick file open, input |
| | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline with winbar (filename + LSP status) |
| | [barbar.nvim](https://github.com/romgrk/barbar.nvim) | Tab/buffer bar |
| | [smear-cursor.nvim](https://github.com/sphmba/smear-cursor.nvim) | Cursor animation |
| | [fidget.nvim](https://github.com/j-hui/fidget.nvim) | Notification UI (overrides vim.notify) |
| | [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |
| | [mini.icons](https://github.com/nvim-mini/mini.nvim) | Icon set |
| | [mini.bufremove](https://github.com/nvim-mini/mini.nvim) | Buffer delete |
| | [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets |
| **Editing** | [nvim-surround](https://github.com/kylechui/nvim-surround) | Surrounding text objects |
| | [flash.nvim](https://github.com/folke/flash.nvim) | Quick jump navigation |
| | [conform.nvim](https://github.com/stevearc/conform.nvim) | Code formatting (`formatters_by_ft` empty; configure per-project) |
| | [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | Search and replace |
| | [ts-comments.nvim](https://github.com/folke/ts-comments.nvim) | Comment string based on treesitter |
| | [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODO/NOTE/WARN (signs disabled) |
| | [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) | Auto-detect indentation |
| **Search** | [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder for files, buffers, grep, git, LSP (also `vim.ui.select` handler) |
| **Files** | [yazi.nvim](https://github.com/mikavilpas/yazi.nvim) | File manager (replaces netrw) |
| **Syntax** | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and parsing |
| **Completion** | [blink.cmp](https://github.com/saghen/blink.cmp) | Autocompletion with Rust fuzzy matcher |
| | [blink.lib](https://github.com/saghen/blink.lib) | Blink dependency library |
| | [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection |
| **LSP** | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| | [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP server installer |
| | [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) | Inline diagnostics (classic preset) |
| **Git** | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs, hunk navigation, blame |
| | [codediff.nvim](https://github.com/esmuellert/codediff.nvim) | Code diff (lazy-loaded via `:CodeDiff`) |
| | [neogit](https://github.com/NeogitOrg/neogit) | Git interface (lazy-loaded via `:Neogit`, floating window) |
| **AI** | [opencode.nvim](https://github.com/nickjvandyke/opencode.nvim) | Opencode integration |
| **Enhanced** | [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown rendering (Obsidian preset) |
| | [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints (Helix preset) |
| **Dependencies** | [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Shared utility library |

## Keymaps

Leader key: `<Space>`

### General

| Key | Mode | Description |
|-----|------|-------------|
| `<Esc>` | n | Clear search highlights |
| `<C-h/j/k/l>` | n | Navigate between windows |
| `<leader>y` | n, v | Copy to system clipboard |
| `<leader>p` | n, v | Paste below (system clipboard) |
| `<leader>P` | n, v | Paste above (system clipboard) |
| `gp` | n | Select last pasted |
| `y` | v | Yank (keeps cursor position) |
| `<` / `>` | v | Indent and keep selection |
| `gg` | n, v | Go to first line |
| `ge` | n, v | Go to last line |
| `gh` | n, v | Go to line start |
| `gl` | n, v | Go to line end |
| `H` / `L` | n | Previous / next buffer |
| `<A-<>` / `<A->>` | n | Move buffer previous / next |
| `<leader><leader>y` | n | Copy diagnostic message to clipboard |
| `<leader>bd` | n | Close buffer (mini.bufremove) |

### File & Search (fzf-lua)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>f` | n | Find files (including hidden) |
| `<leader>bb` | n | Buffers |
| `<leader>/` | n | Live grep (native) |
| `<leader>/` | v | Grep visual selection |
| `<leader>*` | n, v | Search word under cursor |
| `<leader>:` | n | Commands |
| `<leader>q` | n | Quickfix |
| `<leader>"` | n | Registers |
| `<leader>j` | n | Jumps |
| `<leader>'` | n | Resume last fzf picker |

### File Manager (yazi)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>e` | n | Open yazi (current file dir) |
| `<leader>E` | n | Open yazi (cwd) |
| `<C-s>` | n | Grep in directory (inside yazi) |
| `<C-a>` | n | Replace in directory (inside yazi) |

### LSP

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gr` | n | References |
| `gi` | n | Go to implementation |
| `gy` | n | Go to type definition |
| `gRi` | n | Incoming calls |
| `gRo` | n | Outgoing calls |
| `<leader>r` | n | Rename |
| `<leader>k` | n | Hover documentation (rounded border) |
| `<leader>a` | n | Code actions |
| `<leader>s` | n | Document symbols |
| `<leader>S` | n | Workspace symbols |
| `<leader>d` | n | Document diagnostics |
| `<leader>D` | n | Workspace diagnostics |
| `<leader>th` | n | Toggle inlay hints |

### Editing

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>l` | n | Format buffer (async) |
| `gw` | n | Flash jump |

### Git

| Key | Mode | Description |
|-----|------|-------------|
| `]g` / `[g` | n | Next / previous git hunk |
| `<leader>B` | n | Git line blame (full) |
| `<leader>V` | n | Neogit floating window |
| `<leader>gb` | n | Git branches |
| `<leader>gl` | n | Git log |
| `<leader>gs` | n | Git status |
| `<leader>gd` | n | Git diff |
| `<leader>gf` | n | Git log (current file) |
| `:CodeDiff` | - | Code diff (lazy-loaded) |
| `:Neogit` | - | Neogit interface (lazy-loaded) |

### Markdown

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>mr` | n | Toggle markdown rendering (buffer-local) |

### Opencode

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>oc` | n, x | Toggle opencode |
| `<leader>oo` | n, x | Ask opencode (`@this: `) |
| `<leader>oa` | n, x | Execute opencode action |
| `<leader>or` | n, x | Add reference to opencode (operator) |

### Other

| Key | Mode | Description |
|-----|------|-------------|
| `<Esc>` | t | Exit terminal mode |

## Configured LSP Servers

- **rust_analyzer** — Rust
- **ts_ls** — TypeScript / JavaScript
- **lua_ls** — Lua (formatting disabled, handled by StyLua via conform)
- **stylua** — Lua formatter

## Treesitter Languages

Rust, JavaScript, TypeScript, TSX, Zig, Lua, Vue, CSS, HTML

## Notes

- **Netrw is disabled**; yazi handles file management
- **LSP uses Neovim 0.11+ native API** (`vim.lsp.config` / `vim.lsp.enable`), not `lspconfig.setup()`
- **blink.cmp** builds its Rust fuzzy matcher on first load (`cmp.build():wait(60000)`)
- **Lua formatting** is handled by StyLua via conform.nvim, not by lua_ls
- **conform.nvim** has an empty `formatters_by_ft` — formatters are configured per-project
- **Folding** uses treesitter expressions, with all folds open by default (`foldlevel = 99`)
- **fzf-lua** is registered as the `vim.ui.select` handler
- **Which-key** uses the Helix preset
- **Inline diagnostics** use the classic preset from tiny-inline-diagnostic
- **codediff.nvim and neogit** are lazy-loaded via stub commands (`:CodeDiff`, `:Neogit`)
- **Neogit** floating window is bound to `<leader>V`
- **todo-comments** has signs disabled
- **blink.cmp** uses `preset = 'none'` with fully custom key bindings, signature help enabled
- **Yank highlight** briefly highlights text on yank via `TextYankPost` autocmd
- Style: 2-space indent, single quotes, 160 column width (see `.stylua.toml`)
