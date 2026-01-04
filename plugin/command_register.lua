vim.api.nvim_create_user_command("DBQuery", function()
  require("dbfloat.picker").query_database()
end, {})
