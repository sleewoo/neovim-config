return {
  "christoomey/vim-tmux-navigator",
  lazy = true,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<a-left>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<a-down>", "<cmd>TmuxNavigateDown<cr>" },
    { "<a-up>", "<cmd>TmuxNavigateUp<cr>" },
    { "<a-right>", "<cmd>TmuxNavigateRight<cr>" },
    { "<a-end>", "<cmd>TmuxNavigatePrevious<cr>" },
  },
}
