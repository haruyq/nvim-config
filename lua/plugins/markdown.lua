return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },

    opts = {
      render_modes = { "n", "c", "t" },

      heading = {
        enabled = true,
      },

      code = {
        enabled = true,
      },

      checkbox = {
        enabled = true,
      },
    },

    keys = {
      {
        "<leader>mp",
        "<cmd>RenderMarkdown toggle<cr>",
        desc = "Markdown Preview toggle",
      },
      {
        "<leader>mP",
        "<cmd>RenderMarkdown preview<cr>",
        desc = "Markdown Preview",
      },
    },
  },
}