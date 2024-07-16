return {
  "folke/zen-mode.nvim",
  opts = {
    plugins = {
      twilight = { enabled = false },
    },
  },
  keys = {
    { "<leader>z", ":ZenMode<cr>", desc = "ZenMode" },
  },
}
