return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    local biome_cmd = { "biome-check" }

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
        json = biome_cmd,
        jsonc = biome_cmd,
        lua = { "stylua" },
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
        ["*"] = { "trim_whitespace" },
      },

      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "never" }
      end,
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
      conform.format({ async = true, lsp_fallback = false, range = range })
    end, { range = true })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
