local status, lazygit = pcall(require, "lazygit")
if not status then
  vim.notify("没有找到 lazygit")
  return
end
lazygit.setup()
