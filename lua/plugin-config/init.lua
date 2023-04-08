local ok, plenary = pcall(require, "plenary")
if not ok then
  vim.notify("plenary not found")
end
local path = plenary.path
local scandir = plenary.scandir
local f = plenary.functional
local fn = vim.fn
local plugin_config_dir = fn.stdpath("config") .. "/lua/plugin-config"
if not fn.isdirectory(plugin_config_dir) then
  return
end

local disabled_config = {
  "init",
  "template",
}

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
    if not pcall(require, string.format("plugin-config.%s", config)) then
      print("loda config: " .. config .. " error")
    end
  end
end
