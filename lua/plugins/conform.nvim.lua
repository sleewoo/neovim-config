return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    local biome_cmd = { { "biome" } }

    conform.setup({

      formatters = {
        shfmt = {
          inherit = false,
          command = "shfmt",
          args = { "--case-indent", "--indent", 2, "--filename", "$FILENAME" },
        },
      },

      formatters_by_ft = {
        typescript = biome_cmd,
        typescriptreact = biome_cmd,
        javascript = biome_cmd,
        html = biome_cmd,
        json = biome_cmd,
        jsonc = biome_cmd,
        lua = { { "stylua" } },
        sh = { { "shfmt" } },
        yaml = { { "yamlfmt" } },
        ["*"] = { "trim_whitespace" },
      },

      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      conform.format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
  end,
}
