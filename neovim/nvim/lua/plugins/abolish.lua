return {
  {
    "tpope/vim-abolish",
    lazy = false,
    config = function()
      require("which-key").register({
        cr = {
          name = "+coercion",
          s = { desc = "Snake Case" },
          _ = { desc = "Snake Case" },
          m = { desc = "Mixed Case" },
          c = { desc = "Camel Case" },
          u = { desc = "Snake Upper Case" },
          U = { desc = "Snake Upper Case" },
          k = { desc = "Kebab Case" },
          t = { desc = "Title Case (not reversible)" },
          ["-"] = { desc = "Kebab Case (not reversible)" },
          ["."] = { desc = "Dot Case (not reversible)" },
          ["<space>"] = { desc = "Space Case (not reversible)" },
        },
      })
    end,
  },
}
