return {
  "folke/noice.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    messages = {
      level = "warn", -- Only show warnings and errors
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
      command_palette = true, -- position the cmdline and popupmenu together
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
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
