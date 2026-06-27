---@type vim.lsp.Config
return {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 120,
        },
      },
    },
  },
}
