local servers = {
  pyright = { cmd = { "pyright" } },
  tsserver = { cmd = { "typescript-language-server", "--stdio" } },
  volar = { cmd = { "vue-language-server", "--stdio" } },
  svelte = { cmd = { "svelteserver" } },
  tailwindcss = { cmd = { "tailwindcss" } },
  rust_analyzer = { "rust_analyzer" },
  csharp_ls = { cmd = { "csharp-ls" } },
  rnix = { cmd = { "rnix-lsp" } },
  bashls = { cmd = { "bash-language-server", "start" } },
  dartls = { cmd = { "dart", "language-server", "--protocol=lsp" } },
  lua_ls = {
    cmd = { "lua-language-server" },
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      }
    }
  },
}

local augroup = vim.api.nvim_create_augroup("lsp_format_on_save", {})
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  if client.name == "volar" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/neodev.nvim",
        opts = {}
      },
    },
    init = function()
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
      vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
    end,
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for key, value in pairs(servers) do
        require("lspconfig")[key].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          cmd = value.cmd,
          settings = value.settings,
          filetypes = (value.settings or {}).filetypes,
        }
      end
    end
  },
}
