--  ╭───────────────────────────────────────────╮
--  │        Colorscheme Configurations         │
--  ╰───────────────────────────────────────────╯

return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = function(_, _opts)
    return {
      style = "night",
    }
  end,
}
