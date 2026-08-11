return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {},
  keys = {
    {
      "<leader>mv",
      function()
        require("render-markdown").buf_toggle()
      end,
      desc = "Toggle Markdown view",
    },
  },
}
