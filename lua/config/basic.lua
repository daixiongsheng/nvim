vim.g.load = function(name)
	local status, mode = pcall(require, name)
	if not status then
		print("[load] " .. name .. " not found")
	end
	return mode
end


---@class Map
---@field public map fun(mode: string, from: string, to: string | function, opt?: table | string): Map
---@field public map_with fun(mode: string, from: string, to: string, opt?: table<string, any>): Map
---@field public map_buffer fun(buffer: integer, mode: string, from: string, to: string, opt?: table<string, any>): Map
---@field public init fun(target: any): any
local M = {}
M.map = function(mode, from, to, opt)
  if type(opt) == "string" then
    opt = { desc = opt }
  else
    opt = opt or {}
  end
  opt = vim.tbl_deep_extend("force", {}, defaults, opt)
  if type(to) == "function" then
    vim.keymap.set(mode, from, to, opt)
  else
    vim.api.nvim_set_keymap(mode, from, to, opt)
  end
  return M
end

M.map_with = function(mode, from, to, opt)
  vim.api.nvim_set_keymap(mode, from, to, opt)
  return M
end

M.map_buffer = function(buffer, mode, from, to, opt)
  local defaults = {
    noremap = true,
    silent = true,
  }
  if type(opt) == "string" then
    opt = { desc = opt }
  else
    opt = opt or {}
  end
  opt = vim.tbl_deep_extend("force", {}, defaults, opt)
  vim.api.nvim_buf_set_keymap(buffer, mode, from, to, opt)
  return M
end

_G.map = M
vim.g.map = M
