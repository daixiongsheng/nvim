local status, nvim_rooter = pcall(require, "nvim-rooter")
if not status then
	vim.notify("没有找到 nvim_rooter")
	return
end

nvim_rooter.setup({
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true
	},
	rooter_patterns = { '.git', '.hg', '.svn' },
	trigger_patterns = { '*' },
	manual = false,
})
