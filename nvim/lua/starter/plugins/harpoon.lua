local function harpoon()
  return require("harpoon")
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local plugin = harpoon()

    plugin:setup()
    plugin:extend(require("harpoon.extensions").builtins.highlight_current_file())
  end,
  keys = {
    {
      "<leader>ha",
      function()
        harpoon():list():add()
      end,
      desc = "Add file to Harpoon",
    },
    {
      "<leader>hh",
      function()
        local plugin = harpoon()
        plugin.ui:toggle_quick_menu(plugin:list())
      end,
      desc = "Open Harpoon menu",
    },
    {
      "<leader>h1",
      function()
        harpoon():list():select(1)
      end,
      desc = "Open Harpoon file 1",
    },
    {
      "<leader>h2",
      function()
        harpoon():list():select(2)
      end,
      desc = "Open Harpoon file 2",
    },
    {
      "<leader>h3",
      function()
        harpoon():list():select(3)
      end,
      desc = "Open Harpoon file 3",
    },
    {
      "<leader>h4",
      function()
        harpoon():list():select(4)
      end,
      desc = "Open Harpoon file 4",
    },
    {
      "[h",
      function()
        harpoon():list():prev()
      end,
      desc = "Previous Harpoon file",
    },
    {
      "]h",
      function()
        harpoon():list():next()
      end,
      desc = "Next Harpoon file",
    },
  },
}
