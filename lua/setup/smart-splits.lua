local smartSplits = require("smart-splits")

smartSplits.setup({
  -- wrap => Wrap to opposite side
  -- split => Create a new split in the desired direction
  -- stop => Do nothing
  at_edge = "stop",

  -- the default number of lines/columns to resize by at a time
  default_amount = 5,

  -- disable multiplexer navigation if current multiplexer pane is zoomed
  disable_multiplexer_nav_when_zoomed = true,

  -- whether the cursor should follow the buffer when swapping
  cursor_follows_swapped_bufs = true,
})

local keymap = {
  -- resizing splits
  ["<C-S-A-Left>"] = smartSplits.resize_left,
  ["<C-S-A-Down>"] = smartSplits.resize_down,
  ["<C-S-A-Up>"] = smartSplits.resize_up,
  ["<C-S-A-Right>"] = smartSplits.resize_right,

  -- moving between splits
  ["<C-Left>"] = smartSplits.move_cursor_left,
  ["<C-Down>"] = smartSplits.move_cursor_down,
  ["<C-Up>"] = smartSplits.move_cursor_up,
  ["<C-Right>"] = smartSplits.move_cursor_right,
  ["<C-\\>"] = smartSplits.move_cursor_previous,

  -- swapping buffers between windows
  ["<A-S-Left>"] = smartSplits.swap_buf_left,
  ["<A-S-Down>"] = smartSplits.swap_buf_down,
  ["<A-S-Up>"] = smartSplits.swap_buf_up,
  ["<A-S-Right>"] = smartSplits.swap_buf_right,
}

local modes = { "n" }

for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end
