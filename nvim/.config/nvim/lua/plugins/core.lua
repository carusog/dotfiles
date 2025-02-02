return {
  -- Configure LazyVim to load catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  -- add symbols-outline (example plugin)
  {
    -- "simrat39/symbols-outline.nvim",
    -- cmd = "SymbolsOutline",
    -- keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    -- opts = {
    --   -- add your options that should be passed to the setup() function here
    --   position = "right",
    -- },
  },
  -- add syntax highlight to .prisma files
  {
    "prisma/vim-prisma",
  },
}
