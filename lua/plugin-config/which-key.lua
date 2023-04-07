local status, wk = pcall(require, "which-key")
if not status then
  vim.notify("没有找到 which_key")
  return
end

local wk_mappings = {
  d = {
    name = "Do Hover",
  },
  f = {
    name = "Format Code",
  },
  r = {
    name = "Rename",
    n = "Rename",
  },
  S = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search Selected Word" },
  s = { "<cmd>lua require('spectre').open()<cr>", "Open Search" },
  v = {
    name = "DiffView",
    v = { "<cmd>DiffviewOpen<cr>", "Open" },
    c = { "<cmd>DiffviewClose<cr>", "Close" },
  },
  c = {
    c = { "<cmd>ChangeColorScheme<cr>", "ChangeColorScheme" },
  },
  q = {
    name = "Show Diagnostics",
  },
  D = {
    b = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    B = {
      "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      "Toggle condition breakpoint",
    },
    m = {
      "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
      "Toggle message breakpoint",
    },
    r = { "<Cmd>lua require'dap'.run_last()<CR>", "Run last" },
    u = { "<Cmd>lua require('dapui').toggle()<CR>", "Toggle DAP UI" },
  },
}

wk.register(wk_mappings, { prefix = "<leader>" })
wk.setup({})
