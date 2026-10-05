-- Statusline tweaks (2026-10-04):
--  * no clock in lualine_z (desktop shows the time already)
--  * current-function breadcrumb (trouble.nvim symbols) drawn with the statusline highlight
--    trouble ends each piece with %* (reset to StatusLine, bg #262626 here), which painted dark
--    cells into the bar; rewrite those resets to the section-c highlight.
vim.g.trouble_lualine = false
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_z = {}
      local symbols = require("trouble").statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name}",
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        function()
          return (symbols.get():gsub("%%%*", "%%#lualine_c_normal#"))
        end,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end,
  },
}
