local keymap = vim.keymap.set

keymap("n", "<leader>o", "<cmd>SymbolsOutline<cr>")

return {
  "simrat39/symbols-outline.nvim",
  event = "LspAttach",
  config = function()
    require("symbols-outline").setup({})
  end,
}
