return {
  "s1n7ax/nvim-window-picker",
  event = "VeryLazy",
  config = function()
    require("window-picker").setup({
      hint = "floating-big-letter",
      filter_rules = {
        autoselect_one = false,
        include_current_win = true,
      },
    })
  end,
  keys = {
    {
      "<leader>w",
      function()
        local picked = require("window-picker").pick_window()
        if picked then
          vim.api.nvim_set_current_win(picked)
        end
      end,
      desc = "Pick window",
    },
  },
}
