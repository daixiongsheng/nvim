local M = {}

--- @param Map Map
M.setup = function(Map)
  -- move 整行
  Map.map("i", "<a-k>", "<Esc>:m .-2<CR>==gi")
  Map.map("i", "<a-j>", "<Esc>:m .+1<CR>==gi")

  Map.map("i", "<a-K>", "<Esc>:m .-11<CR>==gi")
  Map.map("i", "<a-J>", "<Esc>:m .+10<CR>==gi")
  -- Map.map("n", "<a-k>", ":m .-2<CR>==")
  -- Map.map("n", "<a-j>", ":m .+1<CR>==")
  -- Map.map("v", "<a-k>", ":m '<-2<CR>gv-gv")
  -- Map.map("v", "<a-j>", ":m '>+1<CR>gv-gv")

  -- Normal-mode commands

  Map.map("n", "<a-j>", ":MoveLine(1)<CR>")
  Map.map("n", "<a-k>", ":MoveLine(-1)<CR>")

  Map.map("n", "<a-h>", ":MoveHChar(-1)<CR>")
  Map.map("n", "<a-l>", ":MoveHChar(1)<CR>")

  -- Visual-mode commands
  Map.map("v", "<a-j>", ":MoveBlock(1)<CR>")
  Map.map("v", "<a-k>", ":MoveBlock(-1)<CR>")

  Map.map("v", "<a-h>", ":MoveHBlock(-1)<CR>")
  Map.map("v", "<a-l>", ":MoveHBlock(1)<CR>")
  return {}
end
return M
