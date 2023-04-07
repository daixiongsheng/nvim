local M = {}
M.setup = function(Map)
	Map.map('n', '<leader>S', "<cmd>:lua require('spectre').open()<CR>", 'Search')
	Map.map('n', '<leader>sw', "<cmd>:lua require('spectre').open_visual({select_word=true})<CR>", 'Search selected')
	Map.map('n', '<leader>s', "<cmd>:lua require('spectre').open_visual()<CR>", 'Search')
	Map.map('v', '<leader>s', "<cmd>:lua require('spectre').open_visual()<CR>")
	Map.map('n', '<leader>sp', "<cmd>:lua require('spectre').open_file_search()<CR>")
	return {}
end
return M
