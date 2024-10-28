-- A fuzzy finder for Neovim, allowing for quick file and content searches.
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						-- Close on ESC
						["<ESC>"] = require("telescope.actions").close,
					},
				},
			},
			pickers = {
				find_files = {
					-- Custom find command to ignore .git files and include hidden files
					find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
				},
				grep_string = {
					additional_args = { "--hidden", "-g", "!.git" },
				},
				live_grep = {
					additional_args = { "--hidden", "-g", "!.git" },
				},
			},
			extensions = {
				["ui-select"] = {
					-- Dropdown theme for ui-select extension
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if available
		pcall(require("telescope").load_extension, "ui-select")

		-- Define key mappings for various Telescope functions
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "[F]ind [T]elescope" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "[F]ind Recent Files ([.] for repeat)" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })

		-- Fuzzy search in open files
		vim.keymap.set("n", "<leader>f/", function()
			builtin.live_grep({ grep_open_files = true })
		end, { desc = "[F]ind [/] in Open Files" })

		-- Fuzzy search in the current buffer
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Find Neovim config files
		vim.keymap.set("n", "<leader>fn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[F]ind [N]eovim files" })
	end,
}
