return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    config = function()
      require("ibl").setup {
        indent = { char = "┊" },
        scope = {
          char = "▎",
          show_start = false
        }
      }
    end,
  }
}
