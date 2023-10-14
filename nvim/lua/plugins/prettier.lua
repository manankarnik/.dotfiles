return {
  {
    "MunifTanjim/prettier.nvim",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim"
    },
    opts = {
      bin = 'prettier',
      filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
        "vue",
      },
    }
  }
}
