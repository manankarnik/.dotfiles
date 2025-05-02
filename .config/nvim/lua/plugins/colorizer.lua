-- Automatically highlight color codes in your files.
return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = {
		user_default_options = {
			tailwind = "both",
		},
	},
}
