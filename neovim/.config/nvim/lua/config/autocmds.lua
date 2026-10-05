-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- C/C++ trees (MODS, driver) are indented in 4-space steps; LazyVim's global
-- default is 2, which makes snacks.indent draw two guides per real level.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  group = vim.api.nvim_create_augroup("user_c_indent", { clear = true }),
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})
