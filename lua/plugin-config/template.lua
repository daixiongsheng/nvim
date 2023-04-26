local status, template = pcall(require, "template")
if not status then
  vim.notify("没有找到 template")
  return
end
template.setup()
