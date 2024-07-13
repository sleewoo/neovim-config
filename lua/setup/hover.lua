local hover = require("hover")

hover.setup({
  init = function()
    require("hover.providers.lsp")
    require("hover.providers.diagnostic")
  end,
})

local keymap = {
  ["<C-Space>"] = {
    function()
      hover.hover()
    end,
    "hover.nvim",
  },

  ["<A-,>"] = {
    function()
      hover.hover_switch("previous")
    end,
    "hover.nvim (prev source)",
  },

  ["<A-.>"] = {
    function()
      hover.hover_switch("next")
    end,
    "hover.nvim (next source)",
  },
}

local modes = { "n" }

for keys, map in pairs(keymap) do
  vim.keymap.set(modes, keys, map[1], { desc = map[2] })
end
