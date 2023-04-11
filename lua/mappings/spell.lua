local function add_to_dictionary()
  local word_under_cursor = vim.fn.expand("<cword>")
  local command = "spellgood  " .. word_under_cursor
  vim.api.nvim_command(command)
  vim.notify("Added " .. word_under_cursor .. " to dictionary")
end

local function add_next()
  vim.api.nvim_input("]s")
  vim.schedule(add_to_dictionary)
end

local function add_prev()
  vim.api.nvim_input("[s")
  vim.schedule(add_to_dictionary)
end

local M = {}

--- @param Map Map
M.setup = function(Map)
  Map.map("v", "<leader>dg", add_to_dictionary, "add to dictionary")
  Map.map("n", "<leader>dg", add_to_dictionary, "add to dictionary")

  Map.map("n", "[S", add_prev, "add to dictionary")
  Map.map("n", "]S", add_next, "add to dictionary")

  Map.map("v", "[S", add_prev, "add to dictionary")
  Map.map("v", "]S", add_next, "add to dictionary")
  return {}
end
return M
