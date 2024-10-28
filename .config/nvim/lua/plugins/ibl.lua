-- Implement indentation guides to improve code readability.
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = { char = "┊" },
		scope = {
			char = "▎",
			show_start = false,
		},
	},
}
