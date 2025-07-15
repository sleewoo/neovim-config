return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "LukasPietzschmann/telescope-tabs" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local previewers = require("telescope.previewers")
    local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

    telescope.setup({
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
          "--case-sensitive",
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
            ["<C-space>"] = actions.to_fuzzy_refine,
            ["<C-t>"] = actions.select_tab, -- Ctrl-t to open in new tab
          },
        },
      },

      extensions = {
        file_browser = {
          follow_symlinks = true,
          grouped = true,
          hidden = true,
          no_ignore = true,
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        live_grep_args = {
          auto_quoting = false,
        },
      },
    })

    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")
    telescope.load_extension("notify")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("telescope-tabs")

    vim.keymap.set("n", "<leader>e", function()
      telescope.extensions.file_browser.file_browser()
    end, { desc = "Open File Browser" })

    vim.keymap.set("n", "<a-space>", function()
      telescope.extensions.file_browser.file_browser({ path = "%:p:h", select_buffer = true })
    end, { desc = "Open File Browser at the path of the current buffer" })

    vim.keymap.set("n", "<leader>t?", builtin.builtin, { desc = "Telescope: Help" })
    vim.keymap.set("n", "<leader>tb", builtin.buffers, { desc = "Telescope: Buffers" })
    vim.keymap.set("n", "<leader>th", builtin.search_history, { desc = "Telescope: Search History" })
    vim.keymap.set("n", "<leader>tr", builtin.resume, { desc = "Telescope: Resume" })
    vim.keymap.set("n", "<leader>tn", ":Telescope notify<cr>", { desc = "Telescope: Notify" })
    vim.keymap.set("n", "<leader>tt", "<cmd>Telescope telescope-tabs list_tabs<CR>", { desc = "Select Tab" })

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })

    vim.keymap.set(
      "n",
      "<leader>fg",
      ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      { desc = "Live Grep - Find whatever, with args" }
    )

    vim.keymap.set("n", "<leader>fw", function()
      return live_grep_args_shortcuts.grep_word_under_cursor({ postfix = " -w" })
    end, { desc = "Live Grep - Find Word under cursor" })

    vim.keymap.set("x", "<leader>f", function()
      return live_grep_args_shortcuts.grep_visual_selection({ postfix = "" })
    end, { desc = "Live Grep - Find selected text" })

    vim.keymap.set("n", "?", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in current buffer" })

    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = " Git: Status" })
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = " Git: Commits" })
    vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, { desc = " Git: Current Buffer Commits" })
  end,
}
