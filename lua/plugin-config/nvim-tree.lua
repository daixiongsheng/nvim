-- https://github.com/kyazdani42/nvim-tree.lua
local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("没有找到 nvim-tree")
  return
end

-- 列表操作快捷键
local list_keys = require("keybindings").nvim_tree

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end
  vim.cmd.cd(data.file)
  require("nvim-tree.api").tree.open()
  -- require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
nvim_tree.setup({
  -- 完全禁止内置netrw
  disable_netrw = true,
  -- 覆盖内部的netrw
  respect_buf_cwd = true,
  -- 显示 git 状态图标
  git = {
    enable = true,
    ignore = true,
    timeout = 200,
  },
  -- tab 打开
  open_on_tab = true,
  -- 拦截鼠标
  -- hijack_cursor = true,
  -- project plugin 需要这样设置
  -- sync_root_with_cwd = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    update_root = true,
    ignore_list = {},
  },
  -- prefer_startup_root = true,
  root_dirs = { ".git", ".hg", ".svn" },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  modified = {
    enable = true,
  },
  filters = {
    -- 隐藏 .文件
    dotfiles = false,
    -- 隐藏 node_modules 文件夹
    custom = {
      ".git",
      "node_modules",
      ".cache",
      ".eden-mono",
      ".vscode",
      ".cloudide",
      ".codebase",
    },
    exclude = {
      "only_dev.js",
    },
  },
  view = {
    -- 宽度
    width = 34,
    -- 也可以 'right'
    side = "left",
    -- 隐藏根目录
    hide_root_folder = false,
    -- 自定义列表中快捷键
    mappings = {
      -- 只用定制的快捷键
      custom_only = true,
      list = list_keys,
    },
    -- 显示行数
    number = true,
    relativenumber = false,
    -- 显示图标
    signcolumn = "yes",
  },
  actions = {
    open_file = {
      -- 首次打开大小适配
      resize_window = true,
      -- 打开文件时关闭 tree
      quit_on_open = false,
      window_picker = {
        enable = false,
        exclude = {
          filetype = {
            "notify",
            "packer",
            "qf",
            "spectre_panel",
          },
          buftype = {
            "terminal",
          },
        },
      },
    },
  },
  -- npm install -g wsl-open
  -- https://github.com/4U6U57/wsl-open/
  system_open = {
    -- mac
    cmd = "open",
    -- windows
    -- cmd = "wsl-open",
  },
  renderer = {
    root_folder_modifier = ":t",
    highlight_git = true,
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      },
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
  },
})
