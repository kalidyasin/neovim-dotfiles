return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- bigfile = { enabled = true },
    dashboard = { enabled = true },
    -- explorer = { enabled = true },
    indent = { enabled = true },
    -- input = { enabled = true },
    lazygit = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    -- git = { enabled = true },
    -- quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    --  scratch = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
    { "<leader>lg", function() Snacks.lazygit() end, desc = "[L]azy[G]it" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal", mode = {"n", "t"} },
    { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },

    -- Picker key maps
    { "<leader>ss", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader><space>", function() Snacks.picker.buffers() end, desc = "[ ] Find existing buffers" },
    { "\\", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
    { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
    { "<leader>sp", function() Snacks.picker.pickers() end, desc = "[S]earch [P]ickers" },
    { "<leader>s.", function() Snacks.picker.recent() end, desc = "[S]earch Recent Files ('.' for repeat)" },
  }
}
