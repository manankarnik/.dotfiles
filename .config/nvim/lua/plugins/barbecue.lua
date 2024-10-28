-- Enhance the status line with breadcrumb navigation.
return {
	"utilyre/barbecue.nvim",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	event = "BufReadPre",
	opts = {},
}
