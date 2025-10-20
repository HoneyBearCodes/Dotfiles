--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │                        Neovim Initialization File                            │
--  │       (bootstraps LazyVim, lazy.nvim, and user-defined plugins)              │
--  ╰──────────────────────────────────────────────────────────────────────────────╯

require("config.lazy")

-- Limit the number of notifications
local MAX_NOTIFICATIONS = 4
local active_notifications = 0 -- use number, not table

-- Wrap the original vim.notify
local orig_notify = vim.notify

vim.notify = function(msg, level, opts)
  if active_notifications >= MAX_NOTIFICATIONS then
    return -- Ignore new notifications if limit is reached
  end

  active_notifications = active_notifications + 1

  -- Use the original vim.notify
  orig_notify(msg, level, opts)

  -- Automatically decrease count after a delay (simulate clearing)
  vim.defer_fn(function()
    active_notifications = active_notifications - 1
  end, opts and opts.timeout or 3000)
end
