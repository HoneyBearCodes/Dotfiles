--  ╭────────────────────────────────────────────────────────────╮
--  │            Autocommand configurations for Neovim           │
--  │      (automatically loaded on the VeryLazy event)          │
--  ╰────────────────────────────────────────────────────────────╯

-- ================================
-- Cursor Line Visibility Control
-- ================================

-- This ensures that the cursor line is only visible in the **active window**.
-- It gets disabled when the window loses focus or enters insert mode.
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    -- Retrieve the saved cursorline state, if available
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline") -- Remove the saved state
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl) -- Save current state
      vim.wo.cursorline = false -- Disable cursor line when leaving
    end
  end,
})

-- ================================
-- Automatically Create Missing Directories on Save
-- ================================

-- Ensures that if you try to save a file in a **non-existing directory**,
-- Neovim will **automatically create the required directories**.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p") -- Create the parent directory

    -- Backup handling (modify backup file extension to prevent conflicts)
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- ================================
-- Set Indentation for Specific Filetypes
-- ================================

-- Adjusts indentation settings automatically when opening files of certain types.
vim.api.nvim_create_autocmd({ "FileType", "BufRead", "BufNewFile" }, {
  pattern = { "firrtl", "lua", "javascript", "typescript", "typescriptreact", "text", "query", "systemverilog", "norg" },
  callback = function(args)
    -- Exclude Frida scripts (JavaScript libraries with `.so` extension)
    if vim.bo[args.buf].filetype == "javascript" and vim.fn.expand("%:e") == "so" then
      return
    end

    local buf = args.buf
    vim.bo[buf].shiftwidth = 2 -- Indent width of 2 spaces
    vim.bo[buf].tabstop = 2 -- Tabs appear as 2 spaces
    vim.bo[buf].softtabstop = 2 -- Tab key inserts 2 spaces
    vim.bo[buf].expandtab = true -- Convert tabs to spaces
  end,
})

-- Specific indentation for Markdown files (4 spaces instead of 2)
vim.api.nvim_create_autocmd({ "FileType", "BufRead", "BufNewFile" }, {
  pattern = { "markdown" },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})

-- Disable conceal feature in test files (so all characters are visible)
vim.api.nvim_create_autocmd({ "FileType", "BufRead", "BufNewFile" }, {
  pattern = { "test" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    vim.wo.conceallevel = 0 -- Disable text concealment
  end,
})

-- ================================
-- Set Custom Comment Syntax for Specific Languages
-- ================================

-- Sets the comment style for **C# files** to use `//` instead of the default.
vim.api.nvim_create_autocmd({ "FileType", "BufRead" }, {
  pattern = { "cs" },
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})

-- ================================
-- Add Custom Filetype Detection
-- ================================

-- Tree-Sitter may not detect certain file extensions correctly.
-- This manually associates **unknown file extensions** with the right syntax highlighting.
vim.filetype.add({
  extension = {
    nasm = "nasm", -- NASM assembly
    qmljs = "qmljs", -- QML JavaScript
    pp = "puppet", -- Puppet configuration files
    objdump = "objdump", -- Disassembler outputs
    gn = "gn", -- Google Ninja build files
    gni = "gn", -- GN includes
    tv = "testvector", -- Custom test vector format
    slint = "slint", -- Slint UI language
  },
  pattern = {
    [".*.js.so"] = "javascript", -- Identify JavaScript shared objects
    [".*/%.cache/go%-build/.*"] = "go", -- Identify Go build cache files
  },
})

-- ================================
-- Close Debugging Windows with "q"
-- ================================

-- Adds a shortcut to **close floating debug windows** (`dap-float` and `httpResult`).
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dap-float", "httpResult" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close Window" })
  end,
})

-- Adds a shortcut to **close the DAP (debug adapter protocol) terminal** with `q`
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dap-terminal" },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>bdelete!<cr>", { buffer = event.buf, silent = true, desc = "Close DAP Terminal" })
  end,
})

-- ================================
-- Disable Diagnostics for `.env` Files
-- ================================

-- `.env` files contain environment variables, and LSP diagnostics
-- (e.g., warnings about missing semicolons) are **not useful** here.
vim.api.nvim_create_autocmd("BufRead", {
  pattern = ".env",
  callback = function()
    -- Disable diagnostics for the current buffer
    vim.diagnostic.enable(false, { bufnr = 0 })
  end,
})

-- ================================
-- Disable Tree-Sitter for Large Files
-- ================================

-- If a file is larger than **500 KB**, **disable Tree-Sitter**
-- to **improve performance** (Tree-Sitter can be slow on large files).
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  callback = function()
    local size = vim.fn.getfsize(vim.fn.expand("%:p")) -- Get file size
    if size > 500000 then
      -- vim.treesitter.stop()  -- Uncomment to disable Tree-Sitter
    end
  end,
})
