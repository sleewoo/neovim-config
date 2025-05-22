return {
  "neovim/nvim-lspconfig",
  version = "*",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "cssls",
        "dockerls",
        "html",
        "jsonls",
        "ts_ls",
        "yamlls",
        "taplo",
        "emmet_ls",
        "lua_ls",
        "biome",
      },
      automatic_enable = true,
    })
  end,
}
