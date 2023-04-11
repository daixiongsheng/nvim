local status, move = pcall(require, "nvim-move")
if not status then
  -- vim.notify("没有找到 template")
  return
end
move.setup()
