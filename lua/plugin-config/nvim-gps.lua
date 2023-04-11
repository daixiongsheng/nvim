local status, nvim_gps = pcall(require, "nvim-gps")
if not status then
  vim.notify("没有找到 nvim_gps")
  return
end
nvim_gps.setup()
