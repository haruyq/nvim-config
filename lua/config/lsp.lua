vim.lsp.config("jdtls", {
  cmd = {
    "py",
    vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls",
  },
})

vim.lsp.enable({
  "lua_ls",
  "rust_analyzer",
  "pylsp",
  "jdtls",
  "csharp_ls",
  "ts_ls",
  "marksman",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf

    if client:supports_method("textDocument/definition") then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
    end

    if client:supports_method("textDocument/hover") then
      vim.keymap.set("n", "<leader>k",
        function() vim.lsp.buf.hover({ border = "single" }) end,
        { buffer = buf, desc = "Show hover documentation" })
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/inlineCompletion") then
      vim.lsp.inline_completion.enable(true, { bufnr = buf })
      vim.keymap.set("i", "<Tab>", function()
        if not vim.lsp.inline_completion.get() then
          return "<Tab>"
        end
        if vim.fn.pumvisible() == 1 then
          return "<C-e>"
        end
      end, {
        expr = true,
        buffer = buf,
        desc = "Accept the current inline completion",
      })
    end
  end,
})
