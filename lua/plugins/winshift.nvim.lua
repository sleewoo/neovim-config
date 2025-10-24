return {
  "sindrets/winshift.nvim",
  cmd = {
    "WinShift",
  },
  keys = {
    { "<a-w>", "<cmd>WinShift<cr>", desc = "Interactive window moving with visual feedback" },
  },
  config = function()
    require("winshift").setup({})
  end,
}
