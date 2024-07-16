-- set up neoconf.nvim BEFORE nvim-lspconfig
return {
  "folke/neoconf.nvim",
  config = function()
    require("neoconf").setup()
  end,
}
