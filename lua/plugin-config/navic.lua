local status, navic = pcall(require, "nvim-navic")
if not status then
  vim.notify("没有找到 navic")
  return
end

navic.setup({
  highlight = true,
  lsp = {
    auto_attach = true,
    -- preference = nil
  },
})
