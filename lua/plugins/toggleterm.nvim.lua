return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal

    require("toggleterm").setup({
      shell = "$SHELL -l",
      terminal_mappings = true,
      insert_mappings = true,
      shading_factor = -10,
    })

    -- base term
    local baseTerm = Terminal:new({
      direction = "horizontal",
      on_open = function(term)
        local opts = {}
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<A-Esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-x>", [[<cmd>lua _base_term_toggle()<cr>]], opts)
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", [[<cmd>lua _base_term_toggle()<cr>]], opts)
      end,
    })

    function _base_term_toggle()
      baseTerm:toggle()
    end

    vim.api.nvim_set_keymap("n", "<C-x>", [[<cmd>lua _base_term_toggle()<cr>]], {
      noremap = true,
      silent = true,
    })

    -- lazygit
    local lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
      float_opts = {
        border = "curved",
      },
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>go", "<cmd>lua _lazygit_toggle()<CR>", {
      desc = "Git: Open Lazygit",
      noremap = true,
      silent = true,
    })
  end,
}
