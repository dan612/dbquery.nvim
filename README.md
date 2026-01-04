# DBQuery Neovim Plugin

## Description
A Neovim plugin for querying databases using vim-dadbod.

## Installation
*Lazy.nvim*
```lua
return {
  dir = "dan612/dbquery.nvim",
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

