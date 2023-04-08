local M = {}
M.setup = function(Map)
  local actions = require("glance").actions
  -- Lua
  Map.map("n", "gD", "<CMD>Glance definitions<CR>")
  Map.map("n", "gR", "<CMD>Glance references<CR>")
  Map.map("n", "gY", "<CMD>Glance type_definitions<CR>")
  Map.map("n", "gM", "<CMD>Glance implementations<CR>")
  return {
    mappings = {
      list = {
        ["j"] = actions.next, -- Bring the cursor to the next item in the list
        ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
        ["<Down>"] = actions.next,
        ["<Up>"] = actions.previous,
        ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
        ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
        ["<C-u>"] = actions.preview_scroll_win(5),
        ["<C-d>"] = actions.preview_scroll_win(-5),
        ["v"] = actions.jump_vsplit,
        ["s"] = actions.jump_split,
        ["t"] = actions.jump_tab,
        ["<CR>"] = actions.jump,
        ["o"] = actions.jump,
        ["<leader>l"] = actions.enter_win("preview"), -- Focus preview window
        ["q"] = actions.close,
        ["Q"] = actions.close,
        ["<Esc>"] = actions.close,
        -- ['<Esc>'] = false -- disable a mapping
      },
      preview = {
        ["Q"] = actions.close,
        ["<Tab>"] = actions.next_location,
        ["<S-Tab>"] = actions.previous_location,
        ["<leader>l"] = actions.enter_win("list"), -- Focus list window
      },
    },
  }
end
return M
