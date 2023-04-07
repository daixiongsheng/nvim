local M = {}
M.setup = function(Map)
	local utils = require("yanky.utils")
	local mapping = require("yanky.telescope.mapping")
	require("telescope").load_extension("yank_history")
	Map.map("n", "<leader>a", "<cmd>Telescope yank_history<cr>")
	Map.map("i", "<leader>a", "<cmd>Telescope yank_history<cr>")
	Map.map("v", "<leader>a", "<cmd>Telescope yank_history<cr>")
	return {
		mappings = nil
	}
end
return M
