--  ╭───────────────────────────────────────────╮
--  │         Snacks.nvim Configurations        │
--  ╰───────────────────────────────────────────╯

return {

  "snacks.nvim",
  opts = {
    terminal = {
      win = {
        position = "float",
        border = "rounded",
        title = " Terminal ",
        title_pos = "center",
      },
    },
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
          _______  _        _______                   _________ _______ 
|\     /|(  ___  )( (    /|(  ____ \|\     /||\     /|\__   __/(       )
| )   ( || (   ) ||  \  ( || (    \/( \   / )| )   ( |   ) (   | () () |
| (___) || |   | ||   \ | || (__     \ (_) / | |   | |   | |   | || || |
|  ___  || |   | || (\ \) ||  __)     \   /  ( (   ) )   | |   | |(_)| |
| (   ) || |   | || | \   || (         ) (    \ \_/ /    | |   | |   | |
| )   ( || (___) || )  \  || (____/\   | |     \   /  ___) (___| )   ( |
|/     \|(_______)|/    )_)(_______/   \_/      \_/   \_______/|/     \|
]],

        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },

      sections = {
        { section = "header" },
        { section = "keys", gap = 1 },
        {
          align = "center",
          text = { "󰗦 Shashank Singh 2025", hl = "Title" },
          padding = { 0, 3 },
        },
      },
    },
  },
}
