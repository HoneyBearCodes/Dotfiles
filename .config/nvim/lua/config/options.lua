--  ╭────────────────────────────────────────────────────────────────────────────╮
--  │                Neovim Global Options Configuration                         │
--  │        (automatically loaded before lazy.nvim startup)                     │
--  ╰────────────────────────────────────────────────────────────────────────────╯

-- Enable spell check by default unless in vscode
if not vim.g.vscode then
  vim.o.spell = true
end

-- Set conceal level to 0
-- vim.o.conceallevel = 0

vim.opt.grepprg = "rg --vimgrep --smart-case --"
vim.opt.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

-- Use fish as the default shell globally
vim.opt.shell = "/usr/bin/fish"
