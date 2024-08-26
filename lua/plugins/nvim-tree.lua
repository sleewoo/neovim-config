return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local api = require("nvim-tree.api")
    local lib = require("nvim-tree.lib")

    local function grep_at(node)
      if not node then
        node = lib.get_node_at_cursor()
      end
      local path = node.absolute_path or uv.cwd()
      if node.type ~= "directory" and node.parent then
        path = node.parent.absolute_path
      end
      require("telescope.builtin").live_grep({
        search_dirs = { path },
        prompt_title = string.format("Grep in [%s]", vim.fs.basename(path)),
      })
    end

    local VIEW_WIDTH_FIXED = 40
    local view_width_max = VIEW_WIDTH_FIXED -- fixed to start

    -- toggle the width and redraw
    local function toggle_width_adaptive()
      if view_width_max == -1 then
        view_width_max = VIEW_WIDTH_FIXED
      else
        view_width_max = -1
      end

      require("nvim-tree.api").tree.reload()
    end

    local function get_view_width_max()
      return view_width_max
    end

    local function on_attach(bufnr)
      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      local mappings = {

        ["<CR>"] = { api.node.open.edit, "Open" },
        ["<Tab>"] = { api.node.open.preview, "Open Preview" },
        ["o"] = { api.node.open.edit, "Open" },
        ["O"] = { api.node.open.no_window_picker, "Open: No Window Picker" },
        ["t"] = { api.node.open.tab, "Open: New Tab" },
        ["v"] = { api.node.open.vertical, "Open: Vertical Split" },
        ["s"] = { api.node.open.horizontal, "Open: Horizontal Split" },
        ["<2-LeftMouse>"] = { api.node.open.edit, "Open" },

        ["a"] = { api.fs.create, "Create" },

        ["d"] = { api.fs.trash, "Delete: Trash" },
        ["D"] = { api.fs.remove, "Delete: Permanently" },

        ["r"] = { api.fs.rename, "Rename" },
        ["<A-r>"] = { api.fs.rename_basename, "Rename: Basename" },

        ["<BS>"] = { api.node.navigate.parent_close, "Close Directory" },
        ["P"] = { api.node.navigate.parent, "Parent Directory" },

        [">"] = { api.node.navigate.sibling.next, "Next Sibling" },
        ["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },

        ["="] = { api.tree.expand_all, "Expand All" },
        ["-"] = { api.tree.collapse_all, "Collapse" },

        ["f"] = { api.live_filter.start, "Filter" },
        ["F"] = { api.live_filter.clear, "Clean Filter" },

        ["c"] = { api.fs.copy.node, "Copy" },
        ["x"] = { api.fs.cut, "Cut" },
        ["p"] = { api.fs.paste, "Paste" },

        ["y"] = { api.fs.copy.filename, "Copy Name" },
        ["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
        ["<A-y>"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },

        ["."] = { api.node.run.cmd, "Run Command" },
        ["<C-s>"] = { api.node.run.system, "Run System" },

        ["<A-b>"] = { api.tree.toggle_no_buffer_filter, "Toggle No Buffer" },
        ["<A-g>"] = { api.tree.toggle_git_clean_filter, "Toggle Git Clean" },
        ["<A-i>"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
        ["<A-.>"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
        ["<A-h>"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },

        ["<leader>fg"] = { grep_at, "Grep At" },

        ["<A-w>"] = { toggle_width_adaptive, "Toggle Adaptive Width" },

        ["i"] = { api.node.show_info_popup, "Info" },

        ["?"] = { api.tree.toggle_help, "Help" },

        ["<C-r>"] = { api.tree.reload, "Refresh" },

        ["q"] = { api.tree.close, "Close" },
      }

      for keys, mapping in pairs(mappings) do
        vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
      end
    end

    require("nvim-tree").setup({

      on_attach = on_attach,

      -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
      sync_root_with_cwd = true,

      --false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
      respect_buf_cwd = true,

      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },

      sort = {
        sorter = "name",
        folders_first = true,
      },

      view = {
        preserve_window_proportions = true,
        number = true,
        cursorline = true,
        width = {
          min = 40,
          max = get_view_width_max,
        },
      },

      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
      },

      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },

      renderer = {
        group_empty = false,
        highlight_git = false,
        highlight_opened_files = "none",
        highlight_modified = "icon",
        root_folder_label = function(path)
          path = path:gsub(os.getenv("HOME"), "~", 1)
          return path:gsub("([a-zA-Z])[a-z0-9]+", "%1") .. (path:match("[a-zA-Z]([a-z0-9]*)$") or "")
        end,
        icons = {
          git_placement = "after",
          modified_placement = "after",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "➜",
              untracked = "",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },

      actions = {

        expand_all = {
          exclude = { ".git", "node_modules", "var" },
        },

        open_file = {
          resize_window = false,
        },
      },

      filters = {
        -- Ignore files based on `.gitignore`
        git_ignored = false,
      },

      live_filter = {
        always_show_folders = false,
      },

      update_focused_file = {
        -- Update the focused file on `BufEnter`,
        -- un-collapses the folders recursively until it finds the file.
        enable = true,
        -- Update the root directory of the tree if the file is not under current root directory.
        -- It prefers vim's cwd and `root_dirs`.
        -- Otherwise it falls back to the folder containing the file.
        update_root = true,
        -- List of buffer names and filetypes that will not update the root dir of the tree
        -- if the file isn't found under the current root directory.
        ignore_list = {},
      },
    })

    local nvimTreeFocusOrToggle = function()
      local currentBuf = vim.api.nvim_get_current_buf()
      local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
      if currentBufFt == "NvimTree" then
        api.tree.toggle()
      else
        api.tree.focus()
      end
    end

    vim.keymap.set("n", "<leader>e", nvimTreeFocusOrToggle)
  end,
}
