local M = {}

local database_connect = function()
  local dbs = vim.g.dbs or {}

  local entries = {}
  local names = {}
  for name, url in pairs(dbs) do
    table.insert(names, name)
    entries[name] = url
  end

  vim.ui.select(names, {
    prompt = "Select Database:",
  }, function(choice)
      if choice then
        vim.g.db = entries[choice]
        vim.notify("Connected to " .. choice, vim.log.levels.INFO)
      end
    end)
end

local database_query = function()
  if not vim.g.db then
    vim.notify("No database connection set. Use :DBFloatPick to select one.", vim.log.levels.ERROR)
    return
  end

  -- Create a buffer for the query
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].filetype = "sql"

  -- Open a small floating window
  local width = math.floor(vim.o.columns * 0.6)
  local height = 3
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
    title = " SQL Query ",
    title_pos = "center",
  })

  vim.cmd("startinsert")

  -- Press Enter to execute
  vim.keymap.set("i", "<CR>", function()
    local windows_before = vim.api.nvim_list_wins()
    -- Run DB first (creates split in background)
    vim.cmd("%DB")

    -- Then close the floating window and focus results
    vim.schedule(function()
      -- Close the floating input window
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end

      -- Find the new window that DB created
      local windows_after = vim.api.nvim_list_wins()
      for _, w in ipairs(windows_after) do
        local found = false
        for _, old_w in ipairs(windows_before) do
          if w == old_w then
            found = true
            break
          end
        end
        -- This is a new window - likely the results
        if not found and vim.api.nvim_win_is_valid(w) then
          vim.api.nvim_set_current_win(w)
          vim.cmd("stopinsert")
          break
        end
      end
    end)
  end, { buffer = buf })

  -- Press Esc to cancel
  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, { force = true })
  end, { buffer = buf })
end

M.setup = function()
  vim.keymap.set('n', '<leader>dbc', database_connect, { desc = 'Database Connect' })
  vim.keymap.set('n', '<leader>db', database_query, { desc = 'Database Query' })
end

return M
