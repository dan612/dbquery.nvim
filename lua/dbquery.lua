local M = {}

local hello = function()
  local list = {
    "one",
    "two",
    "three",
    "four",
  }
  vim.print(list)
end

M.setup = function()
  print "setting up dbquery.nvim"
  vim.keymap.set('n', '<leader>H', hello, { desc = 'DBQuery hello' })
end

return M
