-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- vim.o.tabstop = 8 -- A TAB character looks like 4 spaces
-- vim.o.expandtab = false -- Pressing the TAB key will insert spaces instead of a TAB character
-- vim.o.softtabstop = 8 -- Number of spaces inserted instead of a TAB character
-- vim.o.shiftwidth = 8 -- Number of spaces inserted when indenting

vim.lsp.set_log_level("off")
