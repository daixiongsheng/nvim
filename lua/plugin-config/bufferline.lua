local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("没有找到 bufferline")
  return
end
-- bfferline 配置
-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
  options = {
    -- 关闭 Tab 的命令
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- 侧边栏配置
    -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
        separator = false,
      },
    },
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      -- style = "icon" | "underline" | "none",
      style = "icon",
    },
    diagnostics = "nvim_lsp",
    -- 可选，显示 LSP 报错图标
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "E " or (e == "warning" and "W " or "I")
        s = s .. n .. sym
      end
      return s
    end,
  },
})
