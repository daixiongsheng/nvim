local status, nvim_surround = pcall(require, "nvim-surround")
if not status then
  vim.notify("没有找到 nvim_surround")
  return
end

nvim_surround.setup({
  keymaps = require("keybindings").nvim_surround.keymaps,
})
