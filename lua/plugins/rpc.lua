return {
  {
    "vyfor/cord.nvim",
    lazy = false,
    opts = {
      display = {
        theme = "catppuccin",
        flavor = "dark",
        view = "full",
      },

      text = {
        workspace = "Working in Neovim",

        viewing = function(opts)
          return opts.filename
        end,

        editing = function(opts)
          return opts.filename
        end,
      },

      idle = {
        enabled = true,
        timeout = 600000,
        details = "Away from Neovim",
      },

      advanced = {
        discord = {
          reconnect = {
            enabled = true,
            interval = 5000,
            initial = true,
          },
        },
      },
    },
  },
}