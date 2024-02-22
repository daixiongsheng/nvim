local status, mode = pcall(require, "template")
if not status then
  vim.notify("没有找到 mode")
  return
end
mode.setup()
