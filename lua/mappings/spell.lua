local function add_to_dictionary()
  local word_under_cursor = vim.fn.expand("<cword>")
  local command = "spellgood  " .. word_under_cursor
  vim.api.nvim_command(command)
  vim.notify("Added " .. word_under_cursor .. " to dictionary")
end

local M = {}
M.setup = function(Map)
  Map.map("v", "<leader>dg", add_to_dictionary, "add to dictionary")
  Map.map("n", "<leader>dg", add_to_dictionary, "add to dictionary")
  return {}
end
return M
