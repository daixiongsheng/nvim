local status, diffview = pcall(require, "diffview")
if not status then
  vim.notify("没有找到 template")
  return
end
diffview.setup({
  view = {
    merge_tool = {
      -- Config for conflicted files in diff views during a merge or rebase.
      -- layout = "diff3_mixed",
      -- disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
      -- winbar_info = true,         -- See |diffview-config-view.x.winbar_info|
    },
  },
})
