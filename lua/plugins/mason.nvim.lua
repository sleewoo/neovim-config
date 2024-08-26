return {
  "williamboman/mason.nvim",
  version = "*",
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  config = function()
    require("mason").setup()
  end,
}
