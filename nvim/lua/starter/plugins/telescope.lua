return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      ensure_installed = { "swift" },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set(
      "n",
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          theme = "dropdown",
          previewer = false,
          path_display = { "tail" },
        })
      end,
      { desc = "Fuzzy find files in cwd" }
    )
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep in cwd" })
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show changed files" })
  end,
}
