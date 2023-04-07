local status, todo = pcall(require, "todo-comments")
if not status then
  vim.notify("没有找到 todo-comments")
  return
end
todo.setup({
  search = {
    pattern = [[\b@?(KEYWORDS):?]], -- ripgrep regex
  },
  highlight = {
    pattern = [[.*<(KEYWORDS)\s*:?]],
  },
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this FIX keywords
    },
    TODO = { icon = " ", color = "info", alt = { "todo" } },
    HACK = { icon = " ", color = "warning", alt = { "hack" } },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warn", "warning", "xxx" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "perf", "optim", "performance", "optimize" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO", "note", "info" } },
  },
})
