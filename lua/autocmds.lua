local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- 自动切换输入法，需要安装 im-select
-- https://github.com/daipeihust/im-select
autocmd("InsertLeave", {
  group = myAutoGroup,
  callback = require("utils.im-select").macInsertLeave,
})
autocmd("InsertEnter", {
  group = myAutoGroup,
  callback = require("utils.im-select").macInsertEnter,
})

-- 进入Terminal 自动进入插入模式
autocmd("TermOpen", {
  group = myAutoGroup,
  command = "startinsert",
})

local pattern = { "*.lua", "*.py", "*.sh", "*.js", "*.ts", "*.tsx", "*.jsx", "*.css", "*.less", "*.scss" }
-- 保存时自动格式化
autocmd("BufWritePre", {
  group = myAutoGroup,
  pattern = pattern,
  callback = function()
    vim.lsp.buf.format({ sync = true })
  end,
})

-- 失去焦点时自动保存
autocmd({ "FocusLost", "BufLeave" }, {
  group = myAutoGroup,
  pattern = pattern,
  callback = function()
    vim.lsp.buf.format({ sync = true })
    pcall(function()
      vim.cmd("w")
    end)
  end,
})

-- -- 修改lua/plugins.lua 自动更新插件
-- autocmd("BufWritePost", {
--   group = myAutoGroup,
--   -- autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   callback = function()
--     if vim.fn.expand("<afile>") == "lua/plugins.lua" then
--       vim.api.nvim_command("source lua/plugins.lua")
--       vim.api.nvim_command("PackerSync")
--     end
--   end,
-- })

-- autocmd("TextYankPost", {
--   callback = function()
--     vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
--   end,
--   group = myAutoGroup,
--   pattern = "*",
-- })

-- 用o换行不要延续注释
autocmd("BufEnter", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
        - "o" -- O and o, don't continue comments
        + "r" -- But do continue when pressing enter.
  end,
})
