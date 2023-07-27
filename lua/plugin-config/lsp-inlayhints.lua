local status, inlayhints = pcall(require, "lsp-inlayhints")
if not status then
  vim.notify("没有找到 lsp-inlayhints")
  return
end
inlayhints.setup({})
