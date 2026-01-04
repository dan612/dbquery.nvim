# DBQuery Neovim Plugin
![demo720](https://github.com/user-attachments/assets/e1bdb0d1-aa07-49e3-80a9-a6c0cc68442f)

## Description
A Neovim plugin for querying databases using vim-dadbod.

## Installation
*Lazy.nvim*
```lua
return {
  dir = "dan612/dbquery.nvim",
  init = function() -- Add all database connections here.
    vim.g.dbs = {
      sqlite = "sqlite://" .. vim.fn.expand("~/path/to/mydb.sqlite"),
    }
  end,
  config = function()
    require("dbquery").setup()
  end,
  dependencies = {
    "tpope/vim-dadbod",
  },
}
```

## Functions
**database_connect**: Connects to a database using vim-dadbod
- Keymap: `<leader>dbc`

**database_query**: Queries a database using vim-dadbod.
- Keymap: `<leader>db`

## Example Workflow
Press `<leader>dbc` to connect to a database.

Press `<leader>db` to query a database. Press ENTER to execute the query.

The usual vim-dadbod split opens with the results.
