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
        keys = { "f", "F", "t", "T", [";"] = "<a-]>", [","] = "<a-[>" },
        char_actions = function(motion)
          return {
            [";"] = "right", -- set to `right` to always go right
            [","] = "left", -- set to `left` to always go left
            -- clever-f style
            -- [motion:lower()] = "next",
            -- [motion:upper()] = "prev",
            -- jump2d style: same case goes next, opposite case goes prev
            -- [motion] = "next",
            -- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
          }
        end,
      },
    },
  },
  keys = {
    {
      "<leader><leader>",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "<leader>s",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
