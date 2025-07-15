return {
  "nvim-lualine/lualine.nvim",
  config = function()
    -- Never show tabline
    vim.opt.showtabline = 0

    require("lualine").setup({

      options = {
        theme = "catppuccin",
        globalstatus = true,
        ignore_focus = { "toggleterm" },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "diff", "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      winbar = {
        lualine_a = {
          {
            "filename",
            file_status = true,
            newfile_status = false,
            path = 1,
            symbols = {
              modified = "◆",
              readonly = "◇",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_b = { "diagnostics" },
        lualine_y = {
          {
            "tabs",
            mode = 1,
            symbols = {
              modified = "",
            },
            fmt = function(_, ctx)
              for _, b in ipairs(vim.fn.tabpagebuflist(ctx.tabnr)) do
                if vim.api.nvim_buf_get_option(b, "modified") then
                  return ctx.tabnr .. " ◆"
                end
              end
              return ctx.tabnr
            end,
          },
        },
      },

      inactive_winbar = {
        lualine_a = {
          {
            "filename",
            path = 1,
          },
        },
      },

      tabline = {},

      extensions = {
        "fzf",
        "symbols-outline",
        "trouble",
        "quickfix",
        "toggleterm",
        "lazy",
        "mason",
      },
    })
  end,
}
