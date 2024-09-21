-- disabling vim smartindent
vim.opt.smartindent = false

return {
  "nvim-treesitter/nvim-treesitter",
  -- version = "*",
  event = "BufReadPre",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "css",
        "gitcommit",
        "glimmer", -- for handlebars support
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "xml",
        "yaml",
        "http",
      }, -- one of "all", or a list of languages

      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = { "haskell" }, -- list of parsers to ignore installing

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        -- disable = { "" },  -- list of language that will be disabled
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = "<tab>",
          node_decremental = "<s-tab>",
        },
      },

      indent = {
        enable = true,
      },

      rainbow = {
        enable = false,
        extended_mode = true,
      },
    })

    require("ts_context_commentstring").setup({
      enable = true,
      enable_autocmd = false,
    })

    require("nvim-ts-autotag").setup()
  end,
}
