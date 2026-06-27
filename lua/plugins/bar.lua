return {
  {
    "romgrk/barbar.nvim",

    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },

    init = function()
      vim.g.barbar_auto_setup = false
    end,

    opts = {
      icons = {
        preset = "default",

        separator = {
          left = "▏",
          right = "",
        },

        inactive = {
          separator = {
            left = "▏",
            right = "",
          },
        },

        current = {
          separator = {
            left = "▏",
            right = "",
          },
        },

        visible = {
          separator = {
            left = "▏",
            right = "",
          },
        },

        alternate = {
          separator = {
            left = "▏",
            right = "",
          },
        },

        separator_at_end = false,
      },

      sidebar_filetypes = {
        ["neo-tree"] = {
          event = "BufWipeout",
          text = "Explorer",
          align = "center",
        },
      },
    },
  },
}
