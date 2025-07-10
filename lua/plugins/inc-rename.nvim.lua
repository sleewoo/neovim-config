return {
  "smjonas/inc-rename.nvim",
  version = nil,
  config = function()
    vim.keymap.set("n", "<leader>rr", ":IncRename ", { desc = "Refactor: rename symbol" })

    vim.keymap.set("n", "<leader>rf", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, desc = "Refactor: rename symbol (fill in the word under the cursor)" })

    require("inc_rename").setup()
  end,
}
