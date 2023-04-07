local status, db = pcall(require, "dashboard")
if not status then
  vim.notify("没有找到 dashboard")
  return
end

db.custom_center = {
  {
    icon = "  ",
    desc = "Projects                            ",
    action = "Telescope projects",
  },
  {
    icon = "  ",
    desc = "Recently files                      ",
    action = "Telescope oldfiles",
  },
  {
    icon = "  ",
    desc = "Edit keybindings                    ",
    action = "edit ~/.config/nvim/lua/keybindings.lua",
  },
  {
    icon = "  ",
    desc = "Edit Projects                       ",
    action = "edit ~/.config/nvim/lua/keybindings.lua",
  },
  {
    icon = "  ",
    desc = "Edit .bashrc                        ",
    action = "edit ~/.bashrc",
  },
  {
    icon = "  ",
    desc = "Change colorscheme                  ",
    action = "ChangeColorScheme",
  },
  {
    icon = "  ",
    desc = "Edit init.lua                       ",
    action = "edit ~/.config/nvim/init.lua",
  },
  {
    icon = "  ",
    desc = "Find file                           ",
    action = "Telescope find_files",
  },
  {
    icon = "  ",
    desc = "Find text                           ",
    action = "Telescopecope live_grep",
  },
}
db.custom_header = {
  [[]],
  [[███╗   ██╗███████╗██╗  ██╗███████╗███╗   ██╗]],
  [[████╗  ██║██╔════╝██║  ██║██╔════╝████╗  ██║]],
  [[██╔██╗ ██║███████╗███████║█████╗  ██╔██╗ ██║]],
  [[██║╚██╗██║╚════██║██╔══██║██╔══╝  ██║╚██╗██║]],
  [[██║ ╚████║███████║██║  ██║███████╗██║ ╚████║]],
  [[╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝]],
}

db.custom_header = {
  [[]],
  [[          ▀████▀▄▄              ▄█ ]],
  [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
  [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
  [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
  [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
  [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
  [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
  [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
  [[   █   █  █      ▄▄           ▄▀   ]],
}

db.custom_header = {
  [[]],
  [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
  [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
  [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
  [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
  [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
  [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
  [[                                                   ]],
  [[                [ version : 1.0.0 ]                ]],
}

db.custom_header = {
  [[]],
  [[     ██╗██╗   ██╗███████╗     ██╗██╗███╗   ██╗    ██████╗███╗   ██╗]],
  [[     ██║██║   ██║██╔════╝     ██║██║████╗  ██║   ██╔════╝████╗  ██║]],
  [[     ██║██║   ██║█████╗       ██║██║██╔██╗ ██║   ██║     ██╔██╗ ██║]],
  [[██   ██║██║   ██║██╔══╝  ██   ██║██║██║╚██╗██║   ██║     ██║╚██╗██║]],
  [[╚█████╔╝╚██████╔╝███████╗╚█████╔╝██║██║ ╚████║██╗╚██████╗██║ ╚████║]],
  [[ ╚════╝  ╚═════╝ ╚══════╝ ╚════╝ ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝  ╚═══╝]],
  [[                                                                   ]],
  [[                         [ version : 1.0.0 ]                       ]],
}

db.custom_header = {
  [[]],
  [[     ██╗██╗   ██╗███████╗     ██╗██╗███╗   ██╗]],
  [[     ██║██║   ██║██╔════╝     ██║██║████╗  ██║]],
  [[     ██║██║   ██║█████╗       ██║██║██╔██╗ ██║]],
  [[██   ██║██║   ██║██╔══╝  ██   ██║██║██║╚██╗██║]],
  [[╚█████╔╝╚██████╔╝███████╗╚█████╔╝██║██║ ╚████║]],
  [[ ╚════╝  ╚═════╝ ╚══════╝ ╚════╝ ╚═╝╚═╝  ╚═══╝]],
  [[                                              ]],
  [[             [ version : 1.0.0 ]              ]],
  [[]],
  [[]],
}


db.setup({
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Apps',
        group = 'DiagnosticHint',
        action = 'Telescope app',
        key = 'a',
      },
      {
        desc = ' dotfiles',
        group = 'Number',
        action = 'Telescope dotfiles',
        key = 'd',
      },
    },
  },
})
