local opts = {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, buffer)
    require("keybindings").mapLSP.map(buffer)
  end,
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
