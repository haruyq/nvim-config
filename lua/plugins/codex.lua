return {
  "ishiooon/codex.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    keymaps = {
      enabled = true,
      mappings = {
        { mode = "n", lhs = "<leader>cc", rhs = "<cmd>Codex<cr>", desc = "Codex: Toggle" },
        { mode = "n", lhs = "<leader>cf", rhs = "<cmd>CodexFocus<cr>", desc = "Codex: Focus" },
        { mode = "n", lhs = "<leader>cm", rhs = "<cmd>CodexMaximizeToggle<cr>", desc = "Codex: Toggle modal" },
        { mode = "v", lhs = "<leader>cs", rhs = "<cmd>CodexSend<cr>", desc = "Codex: Send selection" },
        { mode = "n", lhs = "<leader>ac", rhs = "<cmd>Codex<cr>", desc = "Codex: Toggle" },
        { mode = "n", lhs = "<C-g>", rhs = "<cmd>Codex<cr>", desc = "Codex: Toggle" },
        { mode = "n", lhs = "<C-i>", rhs = "<cmd>Codex<cr>", desc = "Codex: Toggle" },
        { mode = "t", lhs = "<C-g>", rhs = [[<C-\><C-n><cmd>Codex<cr>]], desc = "Codex: Toggle" },
        { mode = "t", lhs = "<C-i>", rhs = [[<C-\><C-n><cmd>Codex<cr>]], desc = "Codex: Toggle" },
        {
          mode = "n",
          lhs = "<leader>cs",
          rhs = "<cmd>CodexTreeAdd<cr>",
          desc = "Codex: Add file",
          filetypes = { "neo-tree", "oil" },
        },
      },
    },
  },
  keys = {
    { "<leader>cc", "<cmd>Codex<cr>", desc = "Codex: Toggle" },
    { "<leader>cf", "<cmd>CodexFocus<cr>", desc = "Codex: Focus" },
    { "<leader>cm", "<cmd>CodexMaximizeToggle<cr>", desc = "Codex: Toggle modal" },
    { "<leader>cs", "<cmd>CodexSend<cr>", mode = "v", desc = "Codex: Send selection" },
    { "<leader>ac", "<cmd>Codex<cr>", desc = "Codex: Toggle" },
    { "<C-g>", "<cmd>Codex<cr>", desc = "Codex: Toggle" },
    { "<C-i>", "<cmd>Codex<cr>", desc = "Codex: Toggle" },
    { "<C-g>", [[<C-\><C-n><cmd>Codex<cr>]], mode = "t", desc = "Codex: Toggle" },
    { "<C-i>", [[<C-\><C-n><cmd>Codex<cr>]], mode = "t", desc = "Codex: Toggle" },
    {
      "<leader>cs",
      "<cmd>CodexTreeAdd<cr>",
      desc = "Codex: Add file",
      ft = { "neo-tree", "oil" },
    },
  },
}
