local keybindings = require("keybindings")
local ts_utils = require("nvim-lsp-ts-utils")
local coq = require "coq"

local opts = coq.lsp_ensure_capabilities({
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  -- make inlay hints work
  init_options = require("nvim-lsp-ts-utils").init_options,
  on_attach = function(client, buffer)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    -- 绑定快捷键
    keybindings.mapLSP.map(buffer)
    -- defaults
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,
      -- import all
      import_all_timeout = 5000, -- ms
      -- lower numbers = higher priority
      import_all_priorities = {
        same_file = 1,      -- add to existing import statement
        local_files = 2,    -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4,        -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
      -- if false will avoid organizing imports
      always_organize_imports = true,
      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
      filter_out_diagnostics_by_code = {
        80001,
      },
      -- inlay hints
      auto_inlay_hints = true,
      inlay_hints_highlight = "Comment",
      inlay_hints_priority = 200, -- priority of the hint extmarks
      inlay_hints_throttle = 150, -- throttle the inlay hint request
      inlay_hints_format = {
        -- format options for individual hint kind
        Type = {},
        Parameter = {},
        Enum = {},
      },
      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = false,
      watch_dir = nil,
    })
    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)
    -- no default maps, so you may want to define some here
    keybindings.mapTsLSP.map(buffer)
  end,
})

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
