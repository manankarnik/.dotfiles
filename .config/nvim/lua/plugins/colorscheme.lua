-- Set up a custom color scheme for a personalized editing experience.
return {
	"rose-pine/nvim",
	name = "rose-pine",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("rose-pine")
	end,
}
