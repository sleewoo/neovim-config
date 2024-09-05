return {
  "lewis6991/hover.nvim",
  config = function()
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
    }

    local modes = { "n" }

    for keys, map in pairs(keymap) do
      vim.keymap.set(modes, keys, map[1], { desc = map[2] })
    end
  end,
}
