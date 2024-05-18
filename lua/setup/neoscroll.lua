require("neoscroll").setup({
  mappings = { "C-Up", "C-Down", "C-A-Up", "C-A-Down" },
})

local mappings = {}

mappings["<C-Up>"] = { "scroll", { "-0.10", "false", "100" } }
mappings["<C-Down>"] = { "scroll", { "0.10", "false", "100" } }
mappings["<C-A-Up>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
mappings["<C-A-Down>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }

require("neoscroll.config").set_mappings(mappings)
