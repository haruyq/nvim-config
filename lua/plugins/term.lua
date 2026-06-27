return {
  "akinsho/toggleterm.nvim",
  version = "*",

  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup({
      direction = "horizontal",

      size = function(term)
        if term.direction == "horizontal" then
          return math.floor(vim.o.lines * 0.2)
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,

      open_mapping = [[<C-\>]],

      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,

      persist_size = true,
      persist_mode = true,

      hide_numbers = true,
      close_on_exit = true,
      shell = vim.o.shell,

      shade_terminals = true,
      shading_factor = 2,

      on_open = function(term)
        local opts = {
          buffer = term.bufnr,
          silent = true,
        }

        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
      end,
    })

    vim.keymap.set({ "n", "t" }, "<leader>t", "<cmd>ToggleTerm<CR>", {
      silent = true,
      desc = "ターミナルを開閉",
    })
  end,
}
