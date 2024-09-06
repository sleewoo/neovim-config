return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({

      options = {
        theme = "catppuccin",
        globalstatus = true,
        ignore_focus = { "NvimTree", "toggleterm" },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      tabline = {
        lualine_a = {
          {
            "filename",
            file_status = true,
            newfile_status = false,
            path = 1,
            symbols = {
              modified = "●",
              readonly = "◌",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_y = {
          {
            "tabs",
            mode = 1,
            fmt = function(_, context)
              return "◈ " .. context.tabnr
            end,
          },
        },
      },

      extensions = {
        "nvim-tree",
        "symbols-outline",
        "quickfix",
        "toggleterm",
        "lazy",
      },
    })
  end,
}
