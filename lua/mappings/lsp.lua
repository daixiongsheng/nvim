local M = {}

--- @param Map Map
M.setup = function(Map)
  Map.map("n", "<leader>rn", "<cmd>IncRename<CR>")
  Map.map("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true })
  return {
    map = function(buffer)
      local map_buffer = function(mode, from, to, ops)
        Map.map_buffer(buffer, mode, from, to, ops or {})
      end
      -- rename
      -- map_buffer("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
      -- code action
      map_buffer("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
      map_buffer("v", "<leader>ca", "<cmd>Lspsaga range_code_action<CR>", { desc = "Code Action" })
      -- go xx
      map_buffer("n", "gd", "<cmd>lua require'telescope.builtin'.lsp_definitions({ initial_mode = 'normal', })<CR>")
      -- hover
      map_buffer("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
      -- finder
      map_buffer("n", "gR", "<cmd>Lspsaga lsp_finder<CR>")
      -- format
      map_buffer("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ sync = true })<CR>", { desc = "Foramt" })
      map_buffer("v", "<leader>f", "<cmd>lua vim.lsp.buf.format({ sync = true })<CR>", { desc = "Foramt" })
      -- diagnostic
      map_buffer("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>")
      map_buffer("n", "gl", "<cmd>lua vim.diagnostic.setloclist()<CR>")
      map_buffer("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>")
      map_buffer("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
      map_buffer("n", "<F2>", "<cmd>Lspsaga diagnostic_jump_next<CR>")
      map_buffer("n", "<F3>", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

      map_buffer("n", "<C-j>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
      map_buffer("n", "<C-k>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
    end,
  }
end
return M
