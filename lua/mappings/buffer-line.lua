local M = {}

--- @param Map Map
M.setup = function(Map)
  -- New tab
  Map.map("n", "T", "<cmd>tabnew<cr>", "New Tah")
  Map.map("n", "<A-H>", "<cmd>BufferLineMovePrev<cr>", "Move to prew")
  Map.map("n", "<A-L>", "<cmd>BufferLineMoveNext<cr>", "Move tab to next")
  Map.map("n", "<leader>W", "<cmd>Bdelete<cr>", "Close Tab")
  Map.map("n", "<leader>x", "<cmd>w<CR><cmd>Bdelete<cr>", "Save & Close")

  -- 左右Tab切换
  Map.map("n", "H", ":BufferLineCyclePrev<CR>", "Prev Tab")
  Map.map("n", "L", ":BufferLineCycleNext<CR>", "Next Tab")
  -- "moll/vim-bbye" 关闭当前 buffer
  Map.map("n", "<C-w>", ":Bdelete!<CR>", "Close Tab")
  -- 关闭左/右侧标签页
  Map.map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", "Close Left")
  Map.map("n", "<leader>bl", ":BufferLineCloseRight<CR>", "Close Right")
  -- 关闭其他标签页
  Map.map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", "Close Others")
  -- 关闭选中标签页
  Map.map("n", "<leader>bp", ":BufferLinePickClose<CR>", "Close Pick")
  return {}
end
return M
