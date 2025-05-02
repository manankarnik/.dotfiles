local opts = { noremap = true, silent = true }

-- Leader key setup
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- File management
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- Toggle NvimTree

-- Clipboard management
-- stylua: ignore start
vim.keymap.set("x", "<leader>p", '"_dP', opts) -- Paste without overwriting register
vim.keymap.set("x", "<leader>y", '"+y', opts)  -- Yank selected text to system clipboard
vim.keymap.set("n", "<leader>Y", '"+Y', opts)  -- Yank the entire line to system clipboard
-- stylua: ignore end

-- Scrolling
vim.keymap.set("n", "<c-u>", "<c-u>zz", opts) -- Scroll up and center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts) -- Scroll down and center cursor

-- Search navigation
vim.keymap.set("n", "n", "nzzzv", opts) -- Next search result centered
vim.keymap.set("n", "N", "Nzzzv", opts) -- Previous search result centered

-- Diagnostics
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Open diagnostic quickfix list
vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, { desc = "Open [D]iagnostics float" }) -- Open diagnostics float

-- Miscellaneous
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear search highlights
