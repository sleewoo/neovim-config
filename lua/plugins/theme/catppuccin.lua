return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      show_end_of_buffer = true,

      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "light",
        percentage = 0.2, -- percentage of the shade to apply to the inactive window
      },

      integrations = {
        nvim_surround = true,
        lsp_trouble = true,
        which_key = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
