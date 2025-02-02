-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "kj", "<Esc>", { desc = "esc from insert mode" })
vim.keymap.set("i", "jj", "<Esc> :wa<CR>", { desc = "esc from insert mode and save all files", silent = true })

-- Terminal

local Snacks = require("snacks")
local copilot_exists = pcall(require, "copilot")

-- Toggle Copilot
-- See: https://github.com/LazyVim/LazyVim/discussions/4232#discussioncomment-11191278
if copilot_exists then
  Snacks.toggle({
    name = "Copilot Completion",
    color = {
      enabled = "azure",
      disabled = "orange",
    },
    get = function()
      return not require("copilot.client").is_disabled()
    end,
    set = function(state)
      if state then
        require("copilot.command").enable()
      else
        require("copilot.command").disable()
      end
    end,
  }):map("<leader>at")
end
