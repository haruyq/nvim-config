return {
  "haruyq/spotUI-nvim",
  lazy = false,
  config = function()
    require("spotui").setup({
      position = "right-top",
      poll_interval = 2000,
      window = {
        width = 50,
        compact_height = 3,
        expand_duration = 0,
      },
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.schedule(function()
          require("spotui.ui").toggle()
        end)
      end,
    })
  end,
}