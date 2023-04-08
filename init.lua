-- 基础配置
require("basic")
-- 快捷键映射
require("keybindings")
-- Packer插件管理
require("plugins")
-- 自动命令
require("autocmds")
-- 插件配置
require("plugin-config")
-- 内置LSP
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")
-- 格式化
-- require("lsp.formatter")
require("lsp.mason")
require("lsp.null-ls")
-- DAP
-- require("dap.nvim-dap")
-- load colorscheme
pcall(require, "colorscheme")
