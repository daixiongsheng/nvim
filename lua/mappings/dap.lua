local M = {}

--- @param Map Map
M.setup = function(Map)
  -- -- 开始
  -- Map.map("n", "<leader>dd", ":RustDebuggables<CR>")
  -- -- 结束
  -- Map.map(
  -- 	"n",
  -- 	"<leader>de",
  -- 	":lua require'dap'.close()<CR>"
  -- 	.. ":lua require'dap'.terminate()<CR>"
  -- 	.. ":lua require'dap.repl'.close()<CR>"
  -- 	.. ":lua require'dapui'.close()<CR>"
  -- 	.. ":lua require('dap').clear_breakpoints()<CR>"
  -- 	.. "<C-w>o<CR>"
  -- )
  -- -- 继续
  -- Map.map("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
  -- -- 设置断点
  -- Map.map("n", "<leader>dt", ":lua require('dap').toggle_breakpoint()<CR>")
  -- Map.map("n", "<leader>dT", ":lua require('dap').clear_breakpoints()<CR>")
  -- --  stepOver, stepOut, stepInto
  -- Map.map("n", "<leader>dj", ":lua require'dap'.step_over()<CR>")
  -- Map.map("n", "<leader>dk", ":lua require'dap'.step_out()<CR>")
  -- Map.map("n", "<leader>dl", ":lua require'dap'.step_into()<CR>")
  -- -- 弹窗
  -- Map.map("n", "<leader>dh", ":lua require'dapui'.eval()<CR>")
  return {}
end
return M
