-- stylua: ignore start
local options = {
	-- Search settings
	ignorecase = true,        -- Ignore case in searches
    smartcase = true,         -- Use smart case sensitivity: case-sensitive if uppercase letter is present
	incsearch = true,         -- Show matches as you type
	inccommand = "split",     -- Preview substitutions live, as you type

	-- Window splitting behavior
	splitbelow = true,        -- Horizontal splits open below the current window
	splitright = true,        -- Vertical splits open to the right of the current window

	-- User Interface (UI) settings
	title = true,             -- Set the terminal title to the file name
	number = true,            -- Show absolute line numbers
	relativenumber = true,    -- Show relative line numbers for easier navigation
	cursorline = true,        -- Highlight the current line for visibility
	cursorlineopt = "number", -- Highlight only the line number of the current line
	wrap = true,              -- Enable line wrapping for long lines
	breakindent = true,       -- Enable indenting for wrapped lines
	scrolloff = 10,           -- Keep 10 lines visible above and below the cursor
	guicursor = "",           -- Use the default cursor style

	-- File handling options
	swapfile = false,         -- Disable swap files for improved performance
	backup = false,           -- Disable backup files to save disk space
	confirm = true,           -- Confirm file operations (e.g., quit, delete)

	-- Performance settings
	updatetime = 250,         -- Reduce time to wait for triggering events (e.g., completion)

	-- Undo settings
	undofile = true,          -- Enable persistent undo files

	-- Display options
	signcolumn = "yes",       -- Always show the sign column for diagnostics
	timeoutlen = 300,         -- Time in milliseconds to wait for a mapped sequence to complete

	-- Indentation settings
	tabstop = 4,              -- Number of spaces a tab counts for
	shiftwidth = 4,           -- Number of spaces to use for each step of (auto)indent
	expandtab = true,         -- Use spaces instead of tabs
}
-- stylua: ignore end

-- Apply the options
for key, value in pairs(options) do
	vim.opt[key] = value
end
