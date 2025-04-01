-- Set up a custom color scheme for a personalized editing experience.
return {
	"folke/tokyonight.nvim",
	name = "tokyonight",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("tokyonight-night")
	end,
}
