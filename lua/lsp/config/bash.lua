return {
  on_setup = function(server)
    server.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      flags = {
        debounce_text_changes = 150,
      },
      on_attach = function(client, buffer)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false

        require("keybindings").lsp.map(buffer)
      end,
    })
  end,
}
