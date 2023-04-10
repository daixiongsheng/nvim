local M = {}
M.setup = function(Map)
  -- move 整行
  Map.map("i", "<a-k>", "<Esc>:m .-2<CR>==gi")
  Map.map("i", "<a-j>", "<Esc>:m .+1<CR>==gi")

  Map.map("i", "<a-K>", "<Esc>:m .-11<CR>==gi")
  Map.map("i", "<a-J>", "<Esc>:m .+10<CR>==gi")
  -- Map.map("n", "<A-k>", ":m .-2<CR>==")
  -- Map.map("n", "<A-j>", ":m .+1<CR>==")
  -- Map.map("v", "<A-k>", ":m '<-2<CR>gv-gv")
  -- Map.map("v", "<A-j>", ":m '>+1<CR>gv-gv")

  -- Normal-mode commands

  Map.map("n", "<A-j>", ":MoveLine(1)<CR>")
  Map.map("n", "<A-k>", ":MoveLine(-1)<CR>")

  Map.map("n", "<A-h>", ":MoveHChar(-1)<CR>")
  Map.map("n", "<A-l>", ":MoveHChar(1)<CR>")

  -- Visual-mode commands
  Map.map("v", "<A-j>", ":MoveBlock(1)<CR>")
  Map.map("v", "<A-k>", ":MoveBlock(-1)<CR>")

  Map.map("v", "<A-h>", ":MoveHBlock(-1)<CR>")
  Map.map("v", "<A-l>", ":MoveHBlock(1)<CR>")
  return {}
end
return M
