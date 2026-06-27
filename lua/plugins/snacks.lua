return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      explorer = {
        enabled = false,
      },
      picker = {
        enabled = true,
      },
      terminal = {
        enabled = true,
      },
      notifier = {
        enabled = true,
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Search text",
      },
      {
        "<leader>tt",
        function()
          Snacks.terminal()
        end,
        desc = "Terminal",
      },
      {
        "<leader>ac",
        function()
          Snacks.terminal("codex")
        end,
        desc = "Open Codex",
      },
    },
  },
}
