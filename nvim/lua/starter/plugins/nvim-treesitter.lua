local languages = {
  "json",
  "yaml",
  "markdown",
  "markdown_inline",
  "lua",
  "gitignore",
  "swift",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")

      treesitter.setup({})
      treesitter.install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
