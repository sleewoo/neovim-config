require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_vscode").lazy_load({
  paths = { "~/.config/nvim/snippets" },
  override_priority = 1000,
})
