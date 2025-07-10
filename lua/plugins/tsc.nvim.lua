return {
  "dmmulroy/tsc.nvim",
  dependencies = {
    { "folke/trouble.nvim" },
    { "rcarriga/nvim-notify" },
  },
  config = function()
    require("tsc").setup({
      use_trouble_qflist = true,
    })
  end,
}
