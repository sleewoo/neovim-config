return {
  "davidmh/mdx.nvim",
  config = true,
  -- Lazy load only when editing MDX files
  event = "BufEnter *.mdx",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}
