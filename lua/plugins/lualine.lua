local mode_icons = {
  NORMAL = "󰘳",
  INSERT = "󰏫",
  VISUAL = "󰒅",
  ["V-LINE"] = "󰒅",
  ["V-BLOCK"] = "󰒅",
  REPLACE = "󰬴",
  COMMAND = "󰘳",
  TERMINAL = "󰞷",
}

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    init = function()
      vim.opt.showmode = false
    end,

    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },

      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(mode)
              return string.format(" %s %s ", mode_icons[mode] or "󰘳", mode)
            end,
          },
        },

        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
}
