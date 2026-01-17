return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "SergioRibera/cmp-dotenv",
  },
  config = function()
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
      return
    end

    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
      return
    end

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Setup                                                    │
    -- ╰──────────────────────────────────────────────────────────╯

    local icons = {
      terminal = "   ",
      paragraph = "  ",
      buffer = " 🖹",
      bomb = "  ",
      snippet = "  ",
      calculator = "  ",
      folderOpen2 = " ﱮ ",
      tree = "  ",
    }

    local source_mapping = {
      npm = icons.terminal .. "NPM",
      nvim_lsp = icons.paragraph .. "LSP",
      buffer = icons.buffer .. "BUF",
      nvim_lua = icons.bomb,
      luasnip = icons.snippet .. "SNP",
      calc = icons.calculator,
      path = icons.folderOpen2,
      treesitter = icons.tree,
    }

    local buffer_option = {
      -- Complete from all buffers
      get_bufnrs = function()
        return vim.api.nvim_list_bufs()
      end,
    }

    local border_opts = {
      border = "single",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
    }

    cmp.setup({

      completion = {
        autocomplete = false,
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 100 },
        { name = "buffer", priority = 90, option = buffer_option },
        { name = "luasnip", priority = 80 },
        { name = "npm", priority = 70 },
        { name = "dotenv", priority = 60 },
        { name = "html-css", priority = 50 },
      }),

      window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
      },

      mapping = cmp.mapping.preset.insert({

        ["<C-Space>"] = cmp.mapping(
          cmp.mapping.complete({
            reason = cmp.ContextReason.Auto,
          }),
          { "i", "c" }
        ),

        ["<C-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<Cr>"] = cmp.mapping.confirm({ select = false }),
      }),

      experimental = {
        ghost_text = true,
      },
    })
  end,
}
