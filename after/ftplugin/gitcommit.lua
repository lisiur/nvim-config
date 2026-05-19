-- Disable Capitalize the first letter check
vim.opt_local.spellcapcheck = ""

-- Support Chinese, Jananese and Korean
vim.opt_local.spelllang = {"en_us", "cjk"}

-- Specify the dictionary
vim.opt_local.spellfile = vim.fn.expand('~/.config/nvim/spell/git.utf-8.add')
