return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
  },
  keys = {
    {
      "]c",
      function()
        require("gitsigns").nav_hunk("next")
      end,
      desc = "Next Git change",
    },
    {
      "[c",
      function()
        require("gitsigns").nav_hunk("prev")
      end,
      desc = "Previous Git change",
    },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Git change" },
  },
}
