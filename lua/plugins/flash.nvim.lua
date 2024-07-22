return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        -- when `true`, flash will be activated during regular search by default.
        enabled = false,
      },
      char = {
        -- hide after jump when not using jump labels
        autohide = true,
      },
    },
  },
  keys = {
    {
      "<A-s>",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "<A-S>",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
