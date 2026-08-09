local opt = vim.opt -- for conciseness

opt.exrc = true
opt.secure = true

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.scrolloff = 10

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- wrap long lines to the width of the current window
opt.linebreak = true -- wrap at sensible character boundaries when possible
opt.breakindent = true -- preserve indentation on wrapped screen lines

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- true-color terminal support
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Give command entry the bottom row by temporarily hiding the global statusline.
local command_line_status = vim.api.nvim_create_augroup("command-line-status", { clear = true })
local previous_laststatus

vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = command_line_status,
  pattern = ":",
  callback = function()
    previous_laststatus = vim.o.laststatus
    vim.o.laststatus = 0
  end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = command_line_status,
  pattern = ":",
  callback = function()
    if previous_laststatus ~= nil then
      vim.o.laststatus = previous_laststatus
      previous_laststatus = nil
    end
  end,
})
