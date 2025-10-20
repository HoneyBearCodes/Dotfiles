--  ╭──────────────────────────────────────────────────────────────────────╮
--  │                   Keybindings for Neovim                             │
--  │        (automatically loaded on VeryLazy event)                      │
--  ╰──────────────────────────────────────────────────────────────────────╯

-- Map 'jk' to <Esc>
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
