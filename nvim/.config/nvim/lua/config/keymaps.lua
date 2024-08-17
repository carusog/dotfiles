-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "kj", "<Esc>", { desc = "esc from insert mode" })
vim.keymap.set("i", "jj", "<Esc> :wa<CR>", { desc = "esc from insert mode and save all files", silent = true })

-- Terminal
