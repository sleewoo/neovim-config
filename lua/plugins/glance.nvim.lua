return {
  "dnlhc/glance.nvim",
  version = nil,
  lazy = false,
  config = function()
    local glance = require("glance")
    local actions = glance.actions

    vim.keymap.set("n", "gd", "<cmd>Glance definitions<cr>")
    vim.keymap.set("n", "gr", "<cmd>Glance references<cr>")
    vim.keymap.set("n", "gy", "<cmd>Glance type_definitions<cr>")
    vim.keymap.set("n", "gm", "<cmd>Glance implementations<cr>")

    glance.setup({
      mappings = {
        list = {
          ["<C-v>"] = actions.jump_vsplit, -- Open location in vertical split
          ["<C-s>"] = actions.jump_split, -- Open location in horizontal split
          ["<C-t>"] = actions.jump_tab, -- Open in new tab
        },
        preview = {
          ["q"] = actions.close,
        },
      },
    })
  end,
}
