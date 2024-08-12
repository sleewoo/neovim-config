return {
  "karb94/neoscroll.nvim",
  config = function()
    local neoscroll = require("neoscroll")

    neoscroll.setup({ mappings = {} })

    local keymap = {
      ["<C-Up>"] = function()
        neoscroll.scroll(-0.3, { move_cursor = false, duration = 100 })
      end,

      ["<C-S-Up>"] = function()
        neoscroll.ctrl_u({ duration = 250 })
      end,

      ["<C-Down>"] = function()
        neoscroll.scroll(0.3, { move_cursor = false, duration = 100 })
      end,

      ["<C-S-Down>"] = function()
        neoscroll.ctrl_d({ duration = 250 })
      end,
    }

    local modes = { "n", "v", "x" }

    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
