return {
  "vuki656/package-info.nvim",
  event = "BufEnter package.json",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local self = require("package-info")

    self.setup({
      colors = {
        up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
        outdated = "#fc514e", -- Text color for outdated dependency virtual text
      },
      icons = {
        enable = true, -- Whether to display icons
        style = {
          up_to_date = "|  ", -- Icon for up to date dependencies
          outdated = "|  ", -- Icon for outdated dependencies
        },
      },
      autostart = true, -- Whether to autostart when `package.json` is opened
      hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
      hide_unstable_versions = true, -- It hides unstable versions from version list e.g next-11.1.3-canary3
      -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one, if nothing is provided it will use `yarn`
      package_manager = "pnpm",
    })

    local function keymapFactory(key, fn)
      vim.keymap.set({ "n" }, "<leader>n" .. key, fn, { silent = true, noremap = true })
    end

    -- Show dependency versions
    keymapFactory("s", self.show)

    -- Hide dependency versions
    keymapFactory("h", self.hide)

    -- Toggle dependency versions
    keymapFactory("t", self.toggle)

    -- Update dependency on the line
    -- keymapFactory("u", self.update)

    -- Delete dependency on the line
    -- keymapFactory("d", self.delete)

    -- Install a new dependency
    -- keymapFactory("i", self.install)

    -- Install a different dependency version
    -- keymapFactory("p", self.change_version)
  end,
}
