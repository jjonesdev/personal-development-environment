return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 300,
    spec = {
      { "<leader>b", group = "Buffers & breakpoints" },
      { "<leader>d", group = "Debug & diagnostics" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>l", group = "Lazy" },
      { "<leader>m", group = "Tools & messages" },
      { "<leader>s", group = "Splits" },
      { "<leader>t", group = "Tabs & trouble" },
      { "<leader>x", group = "All Xcode Actions" },
      { "<leader>xD", group = "Debugging" },
      { "<leader>xn", group = "Navigation" },
      { "<leader>xm", group = "Tools" },

      -- Xcode actions documented in README.md. Keeping these descriptions here
      -- makes the complete menu available before xcodebuild.nvim is loaded.
      { "<leader>xo", desc = "Open all Xcode actions" },
      { "<leader>xf", desc = "Manage the Xcode project" },
      { "<leader>xb", desc = "Build" },
      { "<leader>xB", desc = "Build for testing" },
      { "<leader>xr", desc = "Build and run" },
      { "<leader>xt", desc = "Run tests", mode = { "n", "v" } },
      { "<leader>xT", desc = "Run current test class" },
      { "<leader>xd", desc = "Select device" },
      { "<leader>xp", desc = "Select test plan" },
      { "<leader>xl", desc = "Toggle build logs" },
      { "<leader>xe", desc = "Toggle test explorer" },
      { "<leader>xc", desc = "Toggle code coverage" },
      { "<leader>xC", desc = "Show code coverage report" },
      { "<leader>xq", desc = "Show quickfix list" },

      -- Git
      { "<leader>gg", desc = "Open LazyGit" },
      { "<leader>gp", desc = "Preview Git change" },
      { "<leader>gr", desc = "Review working tree" },
      { "<leader>gs", desc = "Show changed files" },

      -- Harpoon
      { "<leader>ha", desc = "Add file to Harpoon" },
      { "<leader>hh", desc = "Open Harpoon menu" },
      { "<leader>h1", desc = "Open Harpoon file 1" },
      { "<leader>h2", desc = "Open Harpoon file 2" },
      { "<leader>h3", desc = "Open Harpoon file 3" },
      { "<leader>h4", desc = "Open Harpoon file 4" },

      -- Debugging
      { "<leader>b", desc = "Toggle breakpoint" },
      { "<leader>B", desc = "Toggle message breakpoint" },
      { "<leader>dd", desc = "Build and debug" },
      { "<leader>dr", desc = "Debug without rebuilding" },
      { "<leader>dt", desc = "Debug tests" },
      { "<leader>dT", desc = "Debug current test class" },
      { "<leader>dx", desc = "Terminate debugger" },

      -- Navigation and tools
      { "<leader>e", desc = "Toggle file tree" },
      { "<leader>ff", desc = "Find files" },
      { "<leader>fg", desc = "Live grep" },
      { "<leader>tt", desc = "Toggle Trouble results" },
      { "<leader>mp", desc = "Format buffer or selection", mode = { "n", "v" } },
      { "<leader>ml", desc = "Lint buffer" },
      { "<leader>mm", desc = "Show Neovim messages" },
      { "<leader>mv", desc = "Toggle Markdown view" },
      { "<leader>w", desc = "Save all changes" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ keys = "<leader>", expand = true })
      end,
      desc = "Show all leader keymaps",
    },

    -- Everything needed for iOS development is also reachable from the single
    -- <leader>x hub. These remap to the original bindings so there is only one
    -- implementation of each action.
    { "<leader>xDb", "<leader>b", remap = true, desc = "Toggle breakpoint" },
    { "<leader>xDB", "<leader>B", remap = true, desc = "Toggle message breakpoint" },
    { "<leader>xDd", "<leader>dd", remap = true, desc = "Build and debug" },
    { "<leader>xDr", "<leader>dr", remap = true, desc = "Debug without rebuilding" },
    { "<leader>xDt", "<leader>dt", remap = true, desc = "Debug tests" },
    { "<leader>xDT", "<leader>dT", remap = true, desc = "Debug current test class" },
    { "<leader>xDx", "<leader>dx", remap = true, desc = "Terminate debugger" },
    { "<leader>xDc", "<leader>dc", remap = true, desc = "Continue (during debugging)" },
    { "<leader>xDC", "<leader>dC", remap = true, desc = "Run to cursor (during debugging)" },
    { "<leader>xDs", "<leader>ds", remap = true, desc = "Step over (during debugging)" },
    { "<leader>xDi", "<leader>di", remap = true, desc = "Step into (during debugging)" },
    { "<leader>xDo", "<leader>do", remap = true, desc = "Step out (during debugging)" },
    { "<leader>xDh", "<leader>dh", remap = true, desc = "Hover value (during debugging)", mode = { "n", "v" } },
    { "<leader>xDe", "<leader>de", remap = true, desc = "Evaluate expression (during debugging)", mode = { "n", "v" } },

    { "<leader>xne", "<leader>e", remap = true, desc = "Toggle file tree" },
    { "<leader>xnf", "<leader>ff", remap = true, desc = "Find files" },
    { "<leader>xng", "<leader>fg", remap = true, desc = "Live grep" },
    { "<leader>xnt", "<leader>tt", remap = true, desc = "Toggle Trouble results" },

    { "<leader>xmp", "<leader>mp", remap = true, desc = "Format buffer or selection", mode = { "n", "v" } },
    { "<leader>xml", "<leader>ml", remap = true, desc = "Lint buffer" },
    { "<leader>xmm", "<leader>mm", remap = true, desc = "Show Neovim messages" },
    { "<leader>xmw", "<leader>w", remap = true, desc = "Save all changes" },
  },
}
