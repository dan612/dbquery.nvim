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
  local ok, dadbod = pcall(require, "vim-dadbod")
  if not ok then
    vim.notify("dbquery.nvim requires vim-dadbod", vim.log.levels.ERROR)
    return
  end
  vim.keymap.set('n', '<leader>H', hello, { desc = 'DBQuery hello' })
end

return M
