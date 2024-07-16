vim.keymap.set("n", "gd", "<cmd>Glance definitions<cr>")
vim.keymap.set("n", "gr", "<cmd>Glance references<cr>")
vim.keymap.set("n", "gy", "<cmd>Glance type_definitions<cr>")
vim.keymap.set("n", "gm", "<cmd>Glance implementations<cr>")

return {
  "dnlhc/glance.nvim",
  config = function()
    require("glance").setup()
  end,
}
