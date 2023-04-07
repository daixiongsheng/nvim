local status, feline = pcall(require, "feline")
if not status then
	vim.notify("没有找到 feline")
	return
end
local navic = require("nvim-navic")
local components = {
	active = { {
		{
			provider = function()
				return navic.get_location()
			end,
			enabled = function() return navic.is_available() end,
		}
	}, {}, {} },
}

feline.setup()
feline.winbar.setup({
	components = components
})
