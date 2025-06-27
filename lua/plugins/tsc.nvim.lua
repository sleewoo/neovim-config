return {
  "dmmulroy/tsc.nvim",
  version = "*",
  dependencies = {
    { "folke/trouble.nvim", version = "*" },
    { "rcarriga/nvim-notify", version = "*" },
  },
  config = function()
    require("tsc").setup({
      use_trouble_qflist = true,
    })
  end,
}
