local status, yanky = pcall(require, "yanky")
if not status then
  vim.notify("没有找到 yanky")
  return
end
yanky.setup({
  picker = {
    -- select = {
    -- 	action = nil, -- nil to use default put action
    -- },
    telescope = {
      mappings = require("keybindings").yanky.mappings,
    },
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
})
