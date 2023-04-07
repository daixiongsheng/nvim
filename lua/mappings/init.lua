-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- leader key \\
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
local M = {}
local defaults = {
  noremap = true,
  silent = true,
  nowait = true,
}
M.map = function(mode, from, to, opt)
  if type(opt) == 'string' then
    opt = { desc = opt }
  else
    opt = opt or {}
  end
  opt = vim.tbl_deep_extend("force", {}, defaults, opt)
  if type(to) == 'function' then
    vim.keymap.set(mode, from, to, opt)
  else
    vim.api.nvim_set_keymap(mode, from, to, opt)
  end
end

M.map_with = function(mode, from, to, opt)
  vim.api.nvim_set_keymap(mode, from, to, opt)
end

M.map_buffer = function(buffer, mode, from, to, opt)
  local defaults = {
    noremap = true,
    silent = true,
  }
  if type(opt) == 'string' then
    opt = { desc = opt }
  else
    opt = opt or {}
  end
  opt = vim.tbl_deep_extend("force", {}, defaults, opt)
  vim.api.nvim_buf_set_keymap(buffer, mode, from, to, opt)
end
return M
