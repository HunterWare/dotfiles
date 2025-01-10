-- return {
--   {
--     "numToStr/Navigator.nvim",
--     lazy = false,
--     priority=1000,
--     config = function()
--       require("Navigator").setup()
--       vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
--       vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
--       vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
--       vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
--       -- vim.keymap.set({'n', 't'}, '<C-p>', '<CMD>NavigatorPrevious<CR>')
--     end,
--   },
-- }

return {
  {
    "numToStr/Navigator.nvim",
    event = "VimEnter",
    config = function()
      vim.schedule(function()
        require("Navigator").setup()
      end)
    end,
  },
}
