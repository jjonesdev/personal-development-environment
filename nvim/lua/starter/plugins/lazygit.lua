return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>gg",
      function()
        if vim.fn.executable("lazygit") == 0 then
          vim.notify("LazyGit is not installed. Run: brew install lazygit", vim.log.levels.ERROR)
          return
        end

        vim.cmd.LazyGit()
      end,
      desc = "Open LazyGit",
    },
  },
}
