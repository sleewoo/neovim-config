return {
  "pogyomo/winresize.nvim",
  init = function()
    local resize = function(win, amt, dir)
      return function()
        require("winresize").resize(win, amt, dir)
      end
    end
    vim.keymap.set("n", "<s-a-left>", resize(0, 2, "left"))
    vim.keymap.set("n", "<s-a-down>", resize(0, 1, "down"))
    vim.keymap.set("n", "<s-a-up>", resize(0, 1, "up"))
    vim.keymap.set("n", "<s-a-right>", resize(0, 2, "right"))
  end,
}
