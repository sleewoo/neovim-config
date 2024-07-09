require("hover").setup({
  init = function()
    require("hover.providers.lsp")
    require("hover.providers.diagnostic")
  end,
})

vim.keymap.set("n", "<C-Space>", require("hover").hover, { desc = "hover.nvim" })

vim.keymap.set("n", "<C-,>", function()
  require("hover").hover_switch("previous")
end, { desc = "hover.nvim (previous source)" })

vim.keymap.set("n", "<C-.>", function()
  require("hover").hover_switch("next")
end, { desc = "hover.nvim (next source)" })
