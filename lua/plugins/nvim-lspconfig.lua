return {
  "neovim/nvim-lspconfig",
  version = "*",
  event = "BufReadPre",
  dependencies = {
    "folke/neoconf.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "smjonas/inc-rename.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")

    local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion = cmp_capabilities.textDocument.completion

    local flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 150,
    }

    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "cssls",
        "dockerls",
        "html",
        "jsonls",
        "ts_ls",
        "yamlls",
        "marksman",
        "taplo",
        "volar",
        "emmet_ls",
        "lua_ls",
        "biome",
      },
    })

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader>rr", ":IncRename ", { desc = "Refactor: rename symbol" })
      vim.keymap.set("n", "<leader>rf", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, buffer = bufnr, desc = "Refactor: rename symbol (fill in the word under the cursor)" })
    end

    require("mason-lspconfig").setup_handlers({

      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn"t have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        if require("neoconf").get(server_name .. ".disable") then
          return
        end

        local server_config = {
          capabilities = capabilities,
          flags = flags,
          on_attach = on_attach,
        }

        if server_name == "ts_ls" then
          server_config.filetypes = { "typescript", "typescriptreact" }
        end

        if server_name == "volar" then
          server_config.filetypes = { "vue" }
        end

        if server_name == "emmet_ls" then
          server_config.filetypes = { "typescriptreact", "html", "vue", "css" }
        end

        lspconfig[server_name].setup(server_config)
      end,

      -- dedicated handlers for specific servers
    })
  end,
}
