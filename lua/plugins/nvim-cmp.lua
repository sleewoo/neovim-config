return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  event = "InsertEnter",
  dependencies = {
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "SergioRibera/cmp-dotenv",
    "Jezda1337/nvim-html-css",
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

    local lspkind_status_ok, lspkind = pcall(require, "lspkind")
    if not lspkind_status_ok then
      return
    end

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Setup                                                    │
    -- ╰──────────────────────────────────────────────────────────╯

    local icons = {
      terminal = "  ",
      paragraph = "  ",
      buffer = " 🖹 ",
      bomb = "  ",
      snippet = "  ",
      calculator = "  ",
      folderOpen2 = " ﱮ ",
      tree = "  ",
      html = "  ",
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
      ["html-css"] = icons.html .. "HTML/CSS",
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

    local function format(entry, vim_item)
      -- Get the item with kind from the lspkind plugin
      local item_with_kind = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        symbol_map = source_mapping,
      })(entry, vim_item)

      item_with_kind.kind = lspkind.symbolic(item_with_kind.kind, { with_text = true })
      item_with_kind.menu = source_mapping[entry.source.name]
      item_with_kind.menu = vim.trim(item_with_kind.menu or "")
      item_with_kind.abbr = string.sub(item_with_kind.abbr, 1, item_with_kind.maxwidth)

      return item_with_kind
    end

    local function luasnip_cmp(fallback)
      -- replace the expand_or_jumpable() with expand_or_locally_jumpable()
      -- to only jump inside the snippet region
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end

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
        {
          name = "html-css",
          priority = 50,
          option = {
            enable_on = { "html" },
            notify = false,
            documentation = {
              auto_show = true,
            },
            style_sheets = {
              "https://cdn.jsdelivr.net/npm/bootstrap@4/dist/css/bootstrap.min.css",
            },
          },
        },
      }),

      window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
      },

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = format,
      },

      mapping = cmp.mapping.preset.insert({

        ["<C-Space>"] = cmp.mapping(
          cmp.mapping.complete({
            reason = cmp.ContextReason.Auto,
          }),
          { "i", "c" }
        ),

        ["<A-Left>"] = cmp.mapping(luasnip_cmp, { "i", "s" }),
        ["<A-Right>"] = cmp.mapping(luasnip_cmp, { "i", "s" }),
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
