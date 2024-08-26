return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local previewers = require("telescope.previewers")

    require("telescope").setup({
      defaults = {

        border = true,
        hl_result_eol = true,
        multi_icon = "",

        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--multiline",
        },

        layout_config = {
          horizontal = {
            preview_cutoff = 120,
          },
          prompt_position = "top",
        },

        prompt_prefix = "  ",
        color_devicons = true,
        sorting_strategy = "ascending",
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        -- cache_picker      = false,

        mappings = {
          i = {
            ["<C-s>"] = actions.select_horizontal,
            ["<C-Up>"] = actions.preview_scrolling_up,
            ["<C-Down>"] = actions.preview_scrolling_down,
            -- ["<C-Left>"] = actions.preview_scrolling_left,
            -- ["<C-Right>"] = actions.preview_scrolling_right,
            ["<A-Down>"] = actions.cycle_history_next,
            ["<A-Up>"] = actions.cycle_history_prev,
            ["<esc>"] = actions.close, -- always in insert mode
            ["<C-u>"] = false, -- clear the prompt on <C-u>
          },
        },
      },

      pickers = {
        buffers = {
          mappings = {
            i = {
              -- delete a buffer from picker without closing telescope
              ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      },

      extensions = {
        fzf = {
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("notify")

    vim.keymap.set("n", "<leader>t?", builtin.builtin, {})
    vim.keymap.set("n", "<leader>tb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>th", builtin.search_history, {})
    vim.keymap.set("n", "<leader>tr", builtin.resume, {})
    vim.keymap.set("n", "<leader>tn", ":Telescope notify<cr>", {})

    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})

    vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
    vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, {})
  end,
}
