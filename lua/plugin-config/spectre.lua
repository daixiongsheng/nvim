local status, spectre = pcall(require, "spectre")
if not status then
  vim.notify("没有找到 spectre")
  return
end

spectre.setup({
  live_update = true,
  open_cmd = ":leftabove vnew",
  is_insert_mode = true,
})
