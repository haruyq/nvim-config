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

local codex_buf = nil
local codex_win = nil
local previous_win = nil

local function is_valid_win(win)
  return win ~= nil and vim.api.nvim_win_is_valid(win)
end

local function is_valid_buf(buf)
  return buf ~= nil and vim.api.nvim_buf_is_valid(buf)
end

local function is_codex_buffer(buf)
  return is_valid_buf(buf)
    and vim.b[buf].is_codex_terminal == true
end

local function close_codex()
  local return_win = previous_win

  if is_valid_win(codex_win) then
    vim.api.nvim_win_close(codex_win, true)
  end

  codex_win = nil
  previous_win = nil

  if is_valid_win(return_win) then
    vim.api.nvim_set_current_win(return_win)
  end
end

local function open_codex()
  local current_win = vim.api.nvim_get_current_win()

  if not is_codex_buffer(vim.api.nvim_get_current_buf()) then
    previous_win = current_win
  end

  if is_valid_win(codex_win) then
    vim.api.nvim_set_current_win(codex_win)
    vim.cmd("startinsert")
    return
  end

  if is_valid_buf(codex_buf) then
    local existing_win = vim.fn.bufwinid(codex_buf)

    if existing_win ~= -1 and is_valid_win(existing_win) then
      codex_win = existing_win
      vim.api.nvim_set_current_win(codex_win)
      vim.cmd("startinsert")
      return
    end
  end

  vim.cmd("botright 45vsplit")
  codex_win = vim.api.nvim_get_current_win()

  if is_valid_buf(codex_buf) then
    vim.api.nvim_win_set_buf(codex_win, codex_buf)
  else
    vim.cmd("terminal codex")
    codex_buf = vim.api.nvim_get_current_buf()

    pcall(vim.api.nvim_buf_set_name, codex_buf, "Codex")
    vim.bo[codex_buf].buflisted = false
    vim.b[codex_buf].is_codex_terminal = true
  end

  vim.cmd("startinsert")
end

local function toggle_codex()
  local current_buf = vim.api.nvim_get_current_buf()

  if is_codex_buffer(current_buf) then
    close_codex()
  else
    open_codex()
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function(args)
    local closed_win = tonumber(args.match)

    if closed_win == codex_win then
      codex_win = nil
      previous_win = nil
    end
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  callback = function(args)
    if args.buf == codex_buf then
      codex_buf = nil
      codex_win = nil
      previous_win = nil
    end
  end,
})

for _, lhs in ipairs({ "<C-g>", "<C-i>" }) do
  map("n", lhs, toggle_codex, {
    desc = "Toggle Codex terminal",
    silent = true,
  })

  map("t", lhs, function()
    vim.cmd("stopinsert")
    toggle_codex()
  end, {
    desc = "Toggle Codex terminal",
    silent = true,
  })
end

map("t", "<Esc><Esc>", [[<C-\><C-n>]], {
  desc = "Leave terminal mode",
  silent = true,
})
