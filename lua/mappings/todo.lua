local M = {}
M.setup = function(Map)
  Map.map("n", "]t", function()
    require("todo-comments").jump_next()
  end, {
    desc = "Jump to next todo",
  })
  Map.map("n", "[t", function()
    require("todo-comments").jump_prev()
  end, {
    desc = "Jump to prev todo",
  })
  return {}
end
return M
