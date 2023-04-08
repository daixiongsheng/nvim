local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end
local previewers = require('telescope.previewers')
local Job = require('plenary.job')

local new_maker = function(filepath, buffer, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = 'file',
    args = { '--mime-type', '-b', filepath },
    on_exit = function(j)
      local mime_types = { 'text', 'image' }
      local mime_type = vim.split(j:result()[1], '/')[1]
      for i = 0, #mime_types do
        if mime_types[i] == mime_type then
          previewers.buffer_previewer_maker(filepath, buffer, opts)
          return true
        end
      end
      vim.schedule(function()
        vim.api.nvim_buf_set_lines(buffer, 0, -1, false, { 'BINARY' })
      end)
    end
  }):sync()
end

local mime_hook = function(filepath, buffer, opts)
  local is_image = function(filepath)
    local image_extensions = { 'png', 'jpg', 'ico', }
    local split_path = vim.split(filepath:lower(), '.', { plain = true })
    local extension = split_path[#split_path]
    return vim.tbl_contains(image_extensions, extension)
  end
  if is_image(filepath) then
    local term = vim.api.nvim_open_term(buffer, {})
    local function send_output(_, data, _)
      for _, d in ipairs(data) do
        vim.api.nvim_chan_send(term, d .. '\r\n')
      end
    end

    vim.fn.jobstart(
      {
        'tiv', filepath -- Terminal image viewer command
      },
      { on_stdout = send_output, stdout_buffered = true, pty = true })
  else
    require('telescope.previewers.utils').set_preview_message(buffer, opts.winid, 'Binary cannot be previewed')
  end
end

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- vertical , center , cursor, horizontal
    layout_strategy = "horizontal",
    -- 窗口内快捷键
    mappings = require("keybindings").telescope,
    -- 图片预览
    buffer_previewer_maker = new_maker,
    wrap_results = false,
    preview = {
      mime_hook,
    },
    path_display = { 'absolute' },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_ignore_patterns = {
      '%/.git/',
      '.git/',
      '%/.eden-mono/',
      '%/node_modules/',
      'node_modules',
      '.yarn',
      '%/dist/',
      '%/idl/',
      '%/api/',
      '%/log/',
      '%.d.ts',
      '%.test.ts',
    },
    layout_config = {
      height = 0.95,
      preview_cutoff = 20,
      prompt_position = 'bottom',
      width = 0.9,
    },
  },
  pickers = {
    find_files = {
      theme = "ivy", -- 可选参数： dropdown, cursor, ivy
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_ivy({
        -- even more opts
      }),
    },
  },
})

pcall(telescope.load_extension, "env")
pcall(telescope.load_extension, "ui-select")
