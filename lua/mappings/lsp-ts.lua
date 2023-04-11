local M = {}

--- @param Map Map
M.setup = function(Map)
  return {
    map = function(buffer)
      local map_buffer = function(mode, from, to, opt)
        Map.map_buffer(buffer, mode, from, to, opt)
      end
      map_buffer("n", "gs", ":TSLspOrganize<CR>", "Organize")
      map_buffer("n", "<leader>rN", ":TSLspRenameFile<CR>", "Rename file")
      map_buffer("n", "gi", ":TSLspImportAll<CR>", "Import all")
    end,
  }
end
return M
