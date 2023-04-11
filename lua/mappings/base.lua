local M = {}

--- @param Map Map
M.setup = function(Map)
  local map = Map.map
  local map_with = Map.map_with

  -- reset
  map("v", "q", "")
  map("n", "q", "")
  -- $跳到行尾不带空格 (交换$ 和 g_)
  map("v", "$", "g_")
  map("v", "g_", "$")
  map("n", "$", "g_")
  map("n", "g_", "$")
  -- 保存退出
  map("n", "<leader>w", ":w<CR>")
  map("n", "<leader>wa", ":wall<CR>")
  map("n", "<leader>wq", ":wq<CR>")
  map("n", "<leader>wqa", ":wqall<CR>")
  map("n", "<leader>qa", ":qall<CR>")
  map("n", "<leader>q", ":q<CR>")
  -- 命令行下 Ctrl+j/k  上一个下一个
  map("c", "<C-j>", "<C-n>", { noremap = false })
  map("c", "<C-k>", "<C-p>", { noremap = false })
  -- 上下滚动浏览
  map("n", "<C-j>", "5j")
  map("n", "<C-k>", "5k")
  map("v", "<C-j>", "5j")
  map("v", "<C-k>", "5k")
  -- Quick move
  map("n", "J", "10gj")
  map("n", "K", "10gk")
  map("n", "<C-u>", "10k")
  map("n", "<C-d>", "10j")
  map("v", "J", "10gj")
  map("v", "K", "10gk")
  map("v", "<C-u>", "10k")
  map("v", "<C-d>", "10j")
  -- Clear highlighting on escape in normal mode
  map("n", "<esc>", "<cmd>noh<cr><esc>")
  map("n", "<esc>^[", "<esc>^[")
  -- magic search
  map_with("n", "/", "/\\v", { noremap = true, silent = false })
  map_with("v", "/", "/\\v", { noremap = true, silent = false })
  -- visual模式下缩进代码
  map("v", "<", "<gv")
  map("v", ">", ">gv")
  -- 在visual mode 里粘贴不要复制
  map("v", "p", '"_dP')
  -- insert 模式下，跳到行首行尾
  map("i", "<a-l>", "<ESC>A")
  map("i", "<a-h>", "<ESC>I")
  map("i", "<c-h>", "<left>")
  map("i", "<c-l>", "<right>")
  map("i", "<c-j>", "<down>")
  map("i", "<c-k>", "<up>")

  -- Ctrl + S to save
  map("n", "<C-s>", "<cmd>w<CR>")
  map("i", "<C-s>", "<ESC><cmd>w<CR>a")
  map("v", "<C-s>", "<cmd>w<CR>")

  -- treesitter 折叠
  map("n", "<leader>Z", ":foldclose<CR>")
  map("n", "<leader>z", ":foldopen<CR>")

  -- select all
  map("n", "<c-a>", "gg<s-v>G")
  map("v", "<c-a>", "<esc>gg<s-v>G")
  map("i", "<c-a>", "<esc>gg<s-v>G")
end
return M
