-- 基础配置
require("basic")
-- 快捷键映射
require("keybindings")
-- Packer插件管理
require("plugins")
-- 自动命令
require("autocmds")
-- 插件配置
require("plugin-config.notify")
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
require("plugin-config.nvim-web-devicons")
require("plugin-config.telescope")
require("plugin-config.project")
require("plugin-config.nvim-treesitter")
require("plugin-config.indent-blankline")
require("plugin-config.nvim-lastplace")
require("plugin-config.toggleterm")
require("plugin-config.comment")
require("plugin-config.nvim-autopairs")
require("plugin-config.fidget")
require("plugin-config.gitsigns")
require("plugin-config.conflict-marker")
require("plugin-config.which-key")
require("plugin-config.spectre")
require("plugin-config.todo")
require("plugin-config.nvim-surround")
require("plugin-config.mason")
require("plugin-config.nvim-rooter")
require("plugin-config.navic")
require("plugin-config.navbuddy")
require("plugin-config.feline")
require("plugin-config.yanky")
require("plugin-config.change-colorscheme")
require("plugin-config.nvim-gps")
require("plugin-config.move")
require("plugin-config.inc-rename")
require("plugin-config.glance")

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
