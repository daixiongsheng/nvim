local M = {}

--- @param Map Map
M.setup = function(Map)
  return {
    on_tatch = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = buffer
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "<leader>gj", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "<leader>gk", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
      map("n", "<leader>gS", gs.stage_buffer)
      map("n", "<leader>gu", gs.undo_stage_hunk)
      map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
      map("n", "<leader>gR", gs.reset_buffer)
      map("n", "<leader>gp", gs.preview_hunk)
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end)
      map("n", "<leader>gd", gs.diffthis)
      map("n", "<leader>gD", function()
        gs.diffthis("~")
      end)
      -- toggle
      map("n", "<leader>gtd", gs.toggle_deleted)
      map("n", "<leader>gtb", gs.toggle_current_line_blame)
      -- Text object
      map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  }
end
return M
