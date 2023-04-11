local M = {}

--- @param Map Map
M.setup = function(Map)
  -- 代码注释插件
  -- plugin-config/comment.lua
  -- ctrl + /
  Map.map_with("n", "<C-_>", "gcc", { noremap = false }, "注释")
  Map.map_with("v", "<C-_>", "gcc", { noremap = false }, "注释")
  return {
    -- Normal 模式快捷键
    toggler = {
      line = "gcc", -- 行注释
      block = "gbc", -- 块注释
    },
    -- Visual 模式
    opleader = {
      line = "gc",
      bock = "gb",
    },
  }
end
return M
