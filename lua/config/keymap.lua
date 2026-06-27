vim.opt.timeoutlen = 300

local map = vim.keymap.set

map("n", "WW", "<C-w>p", {
  desc = "Toggle previous window",
  silent = true,
})

map("t", "WW", [[<C-\><C-n><C-w>p]], {
  desc = "Toggle previous window",
  silent = true,
})

map("n", "<A-l>", "<cmd>BufferNext<CR>", {
  desc = "Next buffer",
  silent = true,
})

map("n", "<A-h>", "<cmd>BufferPrevious<CR>", {
  desc = "Previous buffer",
  silent = true,
})

map("n", "<leader>e", "<cmd>Neotree focus<CR>", {
  desc = "Focus Explorer",
  silent = true,
})

map("t", "<leader>e", [[<C-\><C-n><cmd>Neotree focus<CR>]], {
  desc = "Focus Explorer",
  silent = true,
})

local function move_to_editor_and_run(command)
  vim.cmd("stopinsert")

  local current_tab = vim.api.nvim_get_current_tabpage()
  local windows = vim.api.nvim_tabpage_list_wins(current_tab)

  for _, win in ipairs(windows) do
    if vim.api.nvim_win_is_valid(win) then
      local buf = vim.api.nvim_win_get_buf(win)
      local filetype = vim.bo[buf].filetype
      local buftype = vim.bo[buf].buftype

      if filetype ~= "neo-tree" and buftype ~= "terminal" then
        vim.api.nvim_set_current_win(win)
        vim.cmd(command)
        return
      end
    end
  end
end

map("t", "<A-l>", function()
  move_to_editor_and_run("BufferNext")
end, {
  desc = "Next editor buffer",
  silent = true,
})

map("t", "<A-h>", function()
  move_to_editor_and_run("BufferPrevious")
end, {
  desc = "Previous editor buffer",
  silent = true,
})

map("n", "<leader>x", "<cmd>BufferClose<CR>", {
  desc = "Close buffer",
  silent = true,
})

for i = 1, 5 do
  map("n", "<leader>" .. i, "<cmd>BufferGoto " .. i .. "<CR>", {
    silent = true,
  })
end

map("t", "<Esc><Esc>", [[<C-\><C-n>]], {
  desc = "Leave terminal mode",
  silent = true,
})
