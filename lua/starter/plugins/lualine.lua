return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    local colors = {
      background = "#292a30",
      surface = "#2f3239",
      muted = "#696a6e",
      foreground = "#e0e0e1",
    }

    local function active_mode()
      return {
        a = { fg = colors.foreground, bg = colors.surface },
        b = { fg = colors.muted, bg = colors.surface },
        c = { fg = colors.foreground, bg = colors.surface },
      }
    end

    local xcode_dark_hc = {
      normal = active_mode(),
      insert = active_mode(),
      visual = active_mode(),
      replace = active_mode(),
      command = active_mode(),
      terminal = active_mode(),
      inactive = {
        a = { fg = colors.muted, bg = colors.surface },
        b = { fg = colors.muted, bg = colors.surface },
        c = { fg = colors.muted, bg = colors.surface },
      },
    }

    local function xcodebuild_device()
      if vim.g.xcodebuild_platform == "macOS" then
        return " macOS"
      end

      if vim.g.xcodebuild_os then
        return " " .. vim.g.xcodebuild_device_name .. " (" .. vim.g.xcodebuild_os .. ")"
      end

      return " " .. vim.g.xcodebuild_device_name
    end

    lualine.setup({
      options = {
        globalstatus = true,
        theme = xcode_dark_hc,
        symbols = {
          alternate_file = "#",
          directory = "",
          readonly = "",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
        disabled_buftypes = { "quickfix", "prompt" },
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          -- { "mode" },
          { "filename", color = { fg = colors.background, bg = "#dbbbfe", gui = "bold" } },
        },
        lualine_b = {
          { "diagnostics" },
          { "diff" },
          {
            "searchcount",
            maxcount = 999,
            timeout = 500,
          },
        },
        lualine_c = {},
        lualine_x = {
          { "' ' .. vim.g.xcodebuild_last_status", color = { fg = "#78c2b3" } },
          -- { "'󰙨 ' .. vim.g.xcodebuild_test_plan", color = { fg = "#78c2b3", bg = "#292a30" } },
          { xcodebuild_device, color = { fg = "#6bdfff", bg = colors.surface } },
        },
        lualine_y = {
          { "branch", color = { fg = "#b182eb" } },
        },
        lualine_z = {
          { "location", color = { fg = colors.background, bg = "#dbbbfe", gui = "bold" } },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-dap-ui", "quickfix", "trouble", "nvim-tree", "lazy", "mason" },
    })
  end,
}
