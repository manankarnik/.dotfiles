return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
      require("indent_blankline").setup {
        char = "┊",
        show_current_context = true,
        show_trailing_blankline_indent = false
      }
      vim.cmd(":highlight IndentBlanklineContextChar guifg=#b4beff")
    end,
  }
}
