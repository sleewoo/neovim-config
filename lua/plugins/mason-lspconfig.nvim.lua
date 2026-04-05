return {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "cssls",
        "dockerls",
        "html",
        "jsonls",
        "ts_ls",
        "mdx_analyzer",
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
