return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
    keys = { "<leader>f", "<leader>/" },
    config = function()
      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find [F]iles" })
      vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Find Existing [B]uffers" })
      vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "Find Current [W]ord" })
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Find by [G]rep" })
      vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Show [H]elp" })
      vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "Show [D]iagnostics" })
      vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume, { desc = "Find [R]esume" })
      vim.keymap.set("n", "<leader>/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
            winblend = 10,
            previewer = false
          })
        end,
        { desc = "[/] Fuzzily search in current buffer" }
      )
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<ESC>"] = require("telescope.actions").close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_cursor {}
          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  }
}
