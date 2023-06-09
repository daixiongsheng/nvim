local status, notify = pcall(require, "notify")
if not status then
  vim.notify("没有找到 notify")
  return
end

notify.setup({
  background_colour = "#000000",
})
vim.notify = notify

vim.lsp.handlers["textDocument/definition"] = function(err, result, ctx, config)
  local client_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
  if err then
    vim.notify(err.message)
    return
  end
  if result == nil then
    vim.notify("Location not found")
    return
  end
  if vim.tbl_islist(result) and result[1] then
    vim.lsp.util.jump_to_location(result[1], client_encoding)

    if #result > 1 then
      vim.fn.setqflist(vim.lsp.util.locations_to_items(result, client_encoding))
      vim.api.nvim_command("copen")
    end
  else
    vim.lsp.util.jump_to_location(result, client_encoding)
  end
end

local Spinner = {}
Spinner.__index = Spinner
setmetatable(Spinner, {
  __call = function(cls, ...)
    return cls.new(...)
  end,
})

local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

function Spinner.new(msg, lvl, opts)
  local self = setmetatable({}, Spinner)

  self.msg = msg
  self.lvl = lvl
  self.opts = opts or {}
  self.opts.timeout = false

  self:_spin()

  return self
end

function Spinner:_update(msg, lvl, opts)
  -- TODO: debounce
  opts = opts or {}
  opts.replace = self.id
  opts.hide_from_history = true
  self.id = notify(msg, lvl, opts)
end

function Spinner:update(msg, lvl, opts)
  if msg ~= nil then
    self.msg = msg
  end
  if lvl ~= nil then
    self.lvl = lvl
  end
  if opts ~= nil then
    self.opts = opts
  end
end

function Spinner:_spin()
  if self.timer then
    if self.timer:is_closing() then
      return
    end
    self.timer:close()
  end

  local opts = self.opts or {}
  if opts.icon == nil then
    self.frame = (self.frame or 0) % #spinner_frames + 1
    opts.icon = spinner_frames[self.frame]
  end
  self:_update(self.msg, self.lvl, opts)
  self.msg = nil
  self.lvl = nil
  self.opts = nil

  self.timer = vim.loop.new_timer()
  self.timer:start(
    1000 / #spinner_frames,
    0,
    vim.schedule_wrap(function()
      self:_spin()
    end)
  )
end

function Spinner:done(msg, lvl, opts)
  if not self.timer:is_closing() then
    self.timer:close()
  end

  opts = opts or {}
  if opts.timeout == nil then
    opts.timeout = 3000
  end

  self:_update(msg, lvl, opts)
end

-- vim.api.nvim_create_autocmd({ "UIEnter" }, {
--   once = true,
--   callback = function()
--     local spinners = {}

--     local function format_msg(msg, percentage)
--       msg = msg or ""
--       if not percentage then
--         return msg
--       end
--       return string.format("%2d%%\t%s", percentage, msg)
--     end

--     vim.api.nvim_create_autocmd({ "User" }, {
--       pattern = { "LspProgressUpdate" },
--       group = vim.api.nvim_create_augroup("LSPNotify", { clear = true }),
--       desc = "LSP progress notifications",
--       callback = function()
--         for _, c in ipairs(vim.lsp.get_active_clients()) do
--           for token, ctx in pairs(c.messages.progress) do
--             if not spinners[c.id] then
--               spinners[c.id] = {}
--             end
--             local s = spinners[c.id][token]
--             if not ctx.done then
--               if not s then
--                 spinners[c.id][token] = Spinner(format_msg(ctx.message, ctx.percentage), vim.log.levels.INFO, {
--                   title = ctx.title and string.format("%s: %s", c.name, ctx.title) or c.name,
--                 })
--               else
--                 s:update(format_msg(ctx.message, ctx.percentage))
--               end
--             else
--               c.messages.progress[token] = nil
--               if s then
--                 s:done(ctx.message or "Complete", nil, {
--                   icon = "",
--                 })
--                 spinners[c.id][token] = nil
--               end
--             end
--           end
--         end
--       end,
--     })
--   end,
-- })
