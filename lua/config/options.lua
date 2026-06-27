vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "checktime",
})
vim.opt.fillchars:append({
  vert = "▏",
})