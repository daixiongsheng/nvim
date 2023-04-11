return {
  on_setup = function(server)
    server.setup({
      flags = {
        debounce_text_changes = 150,
      },
      on_attach = function(client, buffer)
        -- 禁用格式化功能，交给专门插件插件处理
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false

        -- local function buf_set_option(...) vim.api.nvim_buf_set_option(buffer, ...) end
        -- 绑定快捷键
        require("keybindings").lsp.map(buffer)
      end,
    })
  end,
}
