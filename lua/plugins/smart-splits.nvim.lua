return {
  "mrjones2014/smart-splits.nvim",
  version = "*",
  config = function()
    local smartSplits = require("smart-splits")

    smartSplits.setup({
      -- wrap => Wrap to opposite side
      -- split => Create a new split in the desired direction
      -- stop => Do nothing
      at_edge = "wrap",

      -- the default number of lines/columns to resize by at a time
      default_amount = 5,

      -- disable multiplexer navigation if current multiplexer pane is zoomed
      disable_multiplexer_nav_when_zoomed = false,

      -- whether the cursor should follow the buffer when swapping
      cursor_follows_swapped_bufs = true,
    })

    local keymap = {

      -- moving between splits
      ["<A-Left>"] = smartSplits.move_cursor_left,
      ["<A-Down>"] = smartSplits.move_cursor_down,
      ["<A-Up>"] = smartSplits.move_cursor_up,
      ["<A-Right>"] = smartSplits.move_cursor_right,

      -- swapping buffers between windows
      ["<A-S-Left>"] = smartSplits.swap_buf_left,
      ["<A-S-Down>"] = smartSplits.swap_buf_down,
      ["<A-S-Up>"] = smartSplits.swap_buf_up,
      ["<A-S-Right>"] = smartSplits.swap_buf_right,

      -- resizing splits
      ["<C-S-A-Left>"] = smartSplits.resize_left,
      ["<C-S-A-Down>"] = smartSplits.resize_down,
      ["<C-S-A-Up>"] = smartSplits.resize_up,
      ["<C-S-A-Right>"] = smartSplits.resize_right,
    }

    local modes = { "n" }

    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
