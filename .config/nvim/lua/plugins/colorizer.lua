-- Automatically highlight color codes in your files.
return {
	"NvChad/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = {
		user_default_options = {
			tailwind = "both",
		},
	},
}
