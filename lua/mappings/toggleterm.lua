local M = {}
M.setup = function(Map)
  -- terminal staff
  -- Terminal相关
  Map.map("n", "st", ":sp | terminal<CR>")
  Map.map("n", "stv", ":vsp | terminal<CR>")
  -- Esc 回 Normal 模式
  Map.map("t", "<Esc>", "<C-\\><C-n>")
  Map.map("t", "<esc>", "<C-\\><C-n>")
  Map.map("t", "<C-t>", "<cmd>ToggleTerm<cr>")
  Map.map("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>")
  Map.map("i", "<C-t>", "<cmd>ToggleTerm direction=float<cr>")

  return {
    setup = function(toggleterm)
      -- 自定义 toggleterm 3个不同类型的命令行窗口
      -- <leader>ta 浮动
      -- <leader>tb 右侧
      -- <leader>tc 下方
      -- 特殊lazygit 窗口，需要安装lazygit
      -- <leader>tg lazygit
      vim.keymap.set({ "n", "t" }, "<leader>ta", toggleterm.toggleA)
      vim.keymap.set({ "n", "t" }, "<leader>tb", toggleterm.toggleB)
      vim.keymap.set({ "n", "t" }, "<leader>tc", toggleterm.toggleC)
      vim.keymap.set({ "n", "t" }, "<leader>tg", toggleterm.toggleG)
    end,
    on_open = function(buffer)
      vim.cmd("startinsert!")
      local map_buffer = function(mode, from, to)
        Map.map_buffer(buffer, mode, from, to)
      end
      -- q / <leader>tg 关闭 terminal
      map_buffer("n", "q", "<cmd>close<CR>")
      map_buffer("n", "<leader>tg", "<cmd>close<CR>")
      -- ESC 键取消，留给lazygit
      if vim.fn.mapcheck("<Esc>", "t") ~= "" then
        vim.api.nvim_del_keymap("t", "<Esc>")
      end
    end,
    on_close = function()
      -- 添加回来
      Map.map("t", "<Esc>", "<C-\\><C-n>")
    end,
  }
end
return M
