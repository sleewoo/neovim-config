require("smart-splits").setup({
  -- the default number of lines/columns to resize by at a time
  default_amount = 5,
  -- disable multiplexer navigation if current multiplexer pane is zoomed
  disable_multiplexer_nav_when_zoomed = false,
})

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-left>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-down>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-up>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-right>", require("smart-splits").resize_right)

-- moving between splits
vim.keymap.set("n", "<C-left>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-down>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-up>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-right>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)

-- swapping buffers between windows
vim.keymap.set("n", "<C-A-Left>", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<C-A-Down>", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<C-A-Up>", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<C-A-Right>", require("smart-splits").swap_buf_right)
