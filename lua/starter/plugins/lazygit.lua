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
  config = function()
    if vim.fn.executable("delta") == 0 then
      return
    end

    local config_paths = {}
    local default_config = vim.fn.trim(vim.fn.system({ "lazygit", "--print-config-dir" })) .. "/config.yml"
    if vim.fn.filereadable(default_config) == 1 then
      table.insert(config_paths, default_config)
    end
    table.insert(config_paths, vim.fn.stdpath("config") .. "/config/lazygit.yml")

    vim.g.lazygit_use_custom_config_file_path = 1
    vim.g.lazygit_config_file_path = config_paths
  end,
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
