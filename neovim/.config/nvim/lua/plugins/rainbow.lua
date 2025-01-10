return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
    config = function()
      require("rainbow-delimiters.setup").setup({
        --strategy = {
        --  [""] = rainbow_delimiters.strategy["global"],
        --  commonlisp = rainbow_delimiters.strategy["local"],
        --},
        query = {
          [""] = "rainbow-delimiters",
          latex = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },
}
