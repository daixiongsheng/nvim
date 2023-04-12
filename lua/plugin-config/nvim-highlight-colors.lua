local status, nvim_hightlight_colors = pcall(require, "nvim-highlight-colors")
if not status then
  vim.notify("没有找到 nvim_hightlight_colors")
  return
end
nvim_hightlight_colors.setup()
