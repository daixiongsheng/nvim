local M = {}

--- @param Map Map
M.setup = function(Map)
  local actions = require("telescope.actions")
  local utils = require("yanky.utils")
  local mapping = require("yanky.telescope.mapping")
  require("telescope").load_extension("yank_history")
  Map.map("n", "<leader>a", "<cmd>Telescope yank_history<cr>")
  -- Map.map("i", "<leader>a", "<cmd>Telescope yank_history<cr>")
  Map.map("v", "<leader>a", "<cmd>Telescope yank_history<cr>")
  return {
    mappings = {
      i = {
        ["<c-p>"] = mapping.put("p"),
        ["<c-k>"] = function(...)
          actions.move_selection_previous(...)
        end,
        ["<c-x>"] = mapping.delete(),
        ["<c-r>"] = mapping.set_register(utils.get_default_register()),
      },
      n = {
        p = mapping.put("p"),
        P = mapping.put("P"),
        d = mapping.delete(),
        r = mapping.set_register(utils.get_default_register()),
      },
    },
  }
end
return M
