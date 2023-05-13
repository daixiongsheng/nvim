local M = {}
--- @param Map Map
M.setup = function(Map)
  local status, hop = pcall(require, "hop")
  if not status then
    vim.notify("没有找到 hop")
    return {}
  end
  local directions = require("hop.hint").HintDirection
  Map.map("", "f", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  end, { remap = true })
  Map.map("", "F", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  end, { remap = true })
  Map.map("", "t", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  end, { remap = true })
  Map.map("", "T", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  end, { remap = true })
  Map.map("", "gt", "<cmd>HopWord<cr>")
  Map.map("", "gl", "<cmd>HopLine<cr>")
  Map.map("", "ga", "<cmd>HopAnywhere<cr>")
  Map.map("", "gC", "<cmd>HopAnywhereCurrentLine<cr>")
  return {}
end
return M
