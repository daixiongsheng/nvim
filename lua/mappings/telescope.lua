local M = {}

M.setup = function(Map)
  Map.map("n", "<C-p>", "<cmd>Telescope find_files<cr>")
  Map.map("n", "<C-f>", "<cmd>Telescope live_grep<cr>")
  Map.map("n", "<C-A-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
  Map.map("n", "<C-e>", "<cmd>Telescope oldfiles<cr>")
  return {
    i = {
      -- 上下移动
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
      ["<Down>"] = "move_selection_next",
      ["<Up>"] = "move_selection_previous",
      -- 历史记录
      ["<C-n>"] = "cycle_history_next",
      ["<C-p>"] = "cycle_history_prev",
      -- 关闭窗口
      ["<esc>"] = "close",
      ["<C-c>"] = "close",
      -- 预览窗口上下滚动
      ["<C-u>"] = "preview_scrolling_up",
      ["<C-d>"] = "preview_scrolling_down",
    },
  }
end

return M
