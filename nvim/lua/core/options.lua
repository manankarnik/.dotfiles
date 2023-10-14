local options = {
	ignorecase = true,
	smartcase = true,
	hlsearch = false,
	incsearch = true,
	splitbelow = true,
	splitright = true,
	number = true,
	relativenumber = true,
	cursorline = true,
	title = true,
	wrap = true,
	scrolloff = 6,
	swapfile = false,
	backup = false,
	termguicolors = true,
	confirm = true,
	updatetime = 200,
	guicursor = "",
	cursorlineopt = "number"
}

for key, value in pairs(options) do
	vim.opt[key] = value
end
