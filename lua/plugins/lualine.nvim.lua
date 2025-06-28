local function tabs_indicator_factory(_opts)
  local opts = vim.tbl_extend("force", {
    modified_symbol = "●",
    modified_color = "#e06c75",
    normal_color = nil,
    format = function(count, modified, symbol)
      return modified and string.format("%s %d Tabs", symbol, count) or string.format("%d Tabs", count)
    end,
  }, _opts or {})

  local state = {
    count = vim.fn.tabpagenr("$"),
    modified = false,
  }

  local group = vim.api.nvim_create_augroup("TabStatus", { clear = true })

  local update_state = function()
    state.count = vim.fn.tabpagenr("$")
    state.modified = false
    for tab = 1, state.count do
      for _, bufnr in ipairs(vim.fn.tabpagebuflist(tab)) do
        if vim.bo[bufnr].modified then
          state.modified = true
          return
        end
      end
    end
  end

  vim.api.nvim_create_autocmd({
    "TabEnter",
    "TabClosed",
    "BufModifiedSet",
    "BufEnter",
    "BufWritePost",
  }, {
    group = group,
    callback = update_state,
    desc = "Update tab status indicator state",
  })

  -- Initial update
  update_state()

  return {
    function()
      return opts.format(state.count, state.modified, opts.modified_symbol)
    end,
    color = function()
      return state.modified and { fg = opts.modified_color } or opts.normal_color
    end,
  }
end

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
        lualine_b = { tabs_indicator_factory() },
        lualine_c = { "diff" },
        lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" },
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
              modified = "●",
              readonly = "◌",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_b = { "diagnostics" },
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
