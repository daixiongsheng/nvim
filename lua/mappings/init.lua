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

local defaults = {
  noremap = true,
  silent = true,
  nowait = true,
}

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

local disabled_config = {
  "init",
  "template",
  'lsp-inlayhints',
  'lualine',
  'navic',
  'navbuddy',
  'rust',
  'conflict-marker',
  'gitsigns',
  'fidget',
  'notify',
  -- 'mason',
  -- 'nvim-lastplace',
  -- 'indent-blankline',
  -- 'vim-repeat',
  -- 'vim-trailing-whitespace',
  'formatter',
  -- 'null-ls',
  'nvim-gps',
  -- 'nvim-tree',
  -- 'nvim-treesitter',
}

M.init = function(target)
  local ok, plenary = pcall(require, "plenary")
  if not ok then
    vim.notify("plenary not founed")
    return target
  end
  target = target or {}
  local path = plenary.path
  local f = plenary.functional
  local scandir = plenary.scandir
  local fn = vim.fn
  local plugin_config_dir = fn.stdpath("config") .. "/lua/mappings"
  if not fn.isdirectory(plugin_config_dir) then
    return
  end

  local configs = scandir.scan_dir(plugin_config_dir, {
    add_dirs = false,
    depth = 1,
  })
  for _, value in ipairs(configs) do
    local config_path = vim.split(value, path.path.sep, { plain = true })
    config_path = config_path[#config_path]
    config_path = vim.split(config_path, ".", { plain = true })
    local config = unpack(config_path, 1, #config_path - 1)
    if f.all(function(_, v)
      return v ~= config
    end, disabled_config) then
      local ok, module = pcall(function(name)
        return require(name).setup(M)
      end, string.format("mappings.%s", config))

      if not ok then
        print("loda map config: " .. config .. " error")
      end
      target[string.gsub(config, "-", "_")] = module or {}
    end
  end
  return target
end

return M
