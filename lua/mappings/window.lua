local M = {}

--- @param Map Map
M.setup = function(Map)
  -- windows 分屏快捷键
  -- 取消 s 默认功能
  Map.map("n", "s", "")
  Map.map("n", "sv", ":vsp<CR>")
  Map.map("n", "sh", ":sp<CR>")
  -- 关闭当前
  Map.map("n", "sc", "<C-w>c")
  -- 关闭其他
  Map.map("n", "so", "<C-w>o")
  -- ctrl + hjkl 窗口之间跳转
  Map.map("n", "<C-h>", "<C-w>h")
  Map.map("n", "<C-j>", "<C-w>j")
  Map.map("n", "<C-k>", "<C-w>k")
  Map.map("n", "<C-l>", "<C-w>l")
  -- 左右比例控制
  Map.map("n", "s,", ":vertical resize -4<CR>")
  Map.map("n", "s.", ":vertical resize +4<CR>")
  -- 上下比例
  Map.map("n", "sj", ":resize +4<CR>")
  Map.map("n", "sk", ":resize -4<CR>")
  -- 相等比例
  Map.map("n", "s=", "<C-w>=")
  return {}
end
return M
