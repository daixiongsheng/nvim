local status, navbuddy = pcall(require, "nvim-navbuddy")
if not status then
	vim.notify("没有找到 navbuddy")
	return
end

navbuddy.setup({
	highlight = true,
	lsp = {
		auto_attach = true,
		-- preference = nil
	},
	mappings = require('keybindings').navbuddy.mappings,
})
