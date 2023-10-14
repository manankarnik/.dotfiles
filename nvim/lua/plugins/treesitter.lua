return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup {
        autotag = {
          enable = true,
          enable_close_on_slash = false,
        },
        ensure_installed = { "c", "lua", "rust", "python", "javascript", "vue", "wgsl" },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        modules = {},
        highlight = {
          enable = true,
        }
      }
    end
  }
}
