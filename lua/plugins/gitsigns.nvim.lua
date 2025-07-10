return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      on_attach = function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- Actions
        map("n", "<leader>gdh", gitsigns.preview_hunk, { desc = "Git: Diff Hunk" })
        map("n", "<leader>gdb", gitsigns.diffthis, { desc = "Git: Diff Buffer" })
        map("n", "<leader>gdd", gitsigns.toggle_deleted, { desc = "Git: Show Deleted" })

        map("n", "<leader>gSb", gitsigns.stage_buffer, { desc = "Git: Stage Buffer" })
        map("n", "<leader>gSh", gitsigns.stage_hunk, { desc = "Git: Stage Hunk" })
        map("v", "<leader>gSs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git: Stage Selected" })

        map("n", "<leader>gRb", gitsigns.reset_buffer, { desc = "Git: Reset Buffer" })
        map("n", "<leader>gRh", gitsigns.reset_hunk, { desc = "Git: Reset Hunk" })
        map("v", "<leader>gRs", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git: Reset Selected" })
      end,
    })
  end,
}
