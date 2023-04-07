local status, rename = pcall(require, "inc_rename")
if not status then
  vim.notify("没有找到 rename")
  return
end
rename.setup()
