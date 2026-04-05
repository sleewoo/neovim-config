return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      filters = {
        dotfiles = false, -- Show dotfiles
        git_ignored = false, -- Show gitignored files
        custom = { "^.git$" }, -- Custom patterns to hide
      },
      actions = {
        open_file = {
          resize_window = false, -- don't resize window when opening file
        },
      },
      update_focused_file = {
        enable = true,
      },
    })
  end,
}
