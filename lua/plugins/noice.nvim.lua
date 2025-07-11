return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  event = "VeryLazy",
  opts = {
    messages = {
      level = "warn", -- Only show warnings and errors
    },
    views = {
      cmdline_popup = {
        position = {
          row = 25, -- vertical center
          col = "50%", -- horizontal center (optional)
        },
        size = {
          width = "50%",
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = 28, -- just *below* cmdline_popup
          col = "50%",
        },
        size = {
          width = "50%",
          height = 10,
        },
        border = {
          style = "rounded",
        },
        win_options = {
          winhighlight = {
            Normal = "Normal",
            FloatBorder = "FloatBorder",
          },
        },
      },
    },
    lsp = {
      hover = {
        enabled = false, -- using hover.nvim
      },
      signature = {
        enabled = false,
      },
      message = {
        enabled = false,
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          find = "written", -- Matches "written" in save confirmation
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "%.?%d*%s*[Ll]ines?%.?%s*$", -- Matches line count messages
        },
        opts = { skip = true },
      },
    },
  },
}
