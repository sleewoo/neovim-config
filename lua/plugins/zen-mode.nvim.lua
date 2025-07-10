return {
  "folke/zen-mode.nvim",
  version = nil,
  opts = {
    plugins = {
      twilight = { enabled = false },
    },
  },
  keys = {
    { "<leader>z", ":ZenMode<cr>", desc = "ZenMode" },
  },
}
