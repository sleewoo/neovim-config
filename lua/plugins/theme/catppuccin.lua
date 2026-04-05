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
        percentage = 0.3, -- percentage of the shade to apply to the inactive window
      },

      default_integrations = false,
      auto_integrations = true,
    })

    vim.cmd.colorscheme("catppuccin-nvim")
  end,
}
