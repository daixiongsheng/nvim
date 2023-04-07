local Map = require("mappings.init")
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

-- 命令行下 Ctrl+j/k  上一个下一个
map_with("c", "<C-j>", "<C-n>", { noremap = false })
map_with("c", "<C-k>", "<C-p>", { noremap = false })
-- 保存退出
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>wa", ":wall<CR>")
map("n", "<leader>wq", ":wq<CR>")
map("n", "<leader>wqa", ":wqall<CR>")
map("n", "<leader>qa", ":qall<CR>")
map("n", "<leader>q", ":q<CR>")

-- fix :set wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

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
-- 上下移动选中文本

-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP')

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I")
map("i", "<C-l>", "<ESC>A")

-- Ctrl + S to save
map("n", "<C-s>", "<cmd>w<CR>")
map("i", "<C-s>", "<ESC><cmd>w<CR>a")
map("v", "<C-s>", "<cmd>w<CR>")
-- move 整行
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("n", "<A-k>", ":m .-2<CR>==")
map("n", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m '<-2<CR>gv-gv")
map("v", "<A-j>", ":m '>+1<CR>gv-gv")

-- 插件快捷键
local pluginKeys = {}
-- treesitter 折叠
map("n", "<leader>Z", ":foldclose<CR>")
map("n", "<leader>z", ":foldopen<CR>")

require("mappings.window").setup(Map)
require("mappings.buffer-line").setup(Map)
-- search
require("mappings.search").setup(Map)
-- todo
require("mappings.todo").setup(Map)
-- nvim-tree
pluginKeys.nvimTreeList = require("mappings.nvim-tree").setup(Map)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = require("mappings.telescope").setup(Map)
-- 注释
pluginKeys.comment = require("mappings.comment").setup(Map)
-- lsp
pluginKeys.mapLSP = require("mappings.lsp").setup(Map)
-- ts
pluginKeys.mapTsLSP = require("mappings.lsp-ts").setup(Map)
-- dap
pluginKeys.mapDAP = require("mappings.dap").setup(Map)
-- nvim-cmp 自动补全
pluginKeys.cmp = require("mappings.cmp").setup(Map)
-- toggleterm
pluginKeys.mapToggleTerm = require("mappings.toggleterm").setup(Map)
-- gitsigns
pluginKeys.gitsigns = require("mappings.gitsigns").setup(Map)
-- nvim_surround
pluginKeys.nvim_surround = require("mappings.nvim-surround").setup(Map)
pluginKeys.navbuddy = require("mappings.navbuddy").setup(Map)
pluginKeys.yanky = require("mappings.yanky").setup(Map)
return pluginKeys
