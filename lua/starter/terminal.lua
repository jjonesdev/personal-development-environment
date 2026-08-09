local M = {}

function M.open(command, options)
  options = options or {}

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[buffer].bufhidden = "wipe"

  local window = vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
    title = options.title,
    title_pos = "center",
  })

  local job = vim.fn.jobstart(command, {
    term = true,
    cwd = options.cwd,
    on_exit = function()
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(window) then
          vim.api.nvim_win_close(window, true)
        end
      end)
    end,
  })

  if job <= 0 then
    vim.api.nvim_win_close(window, true)
    vim.notify("Unable to start " .. command[1], vim.log.levels.ERROR)
    return
  end

  vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n><cmd>close<cr>]], {
    buffer = buffer,
    desc = "Close terminal",
  })
  vim.cmd.startinsert()
end

return M
