-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins


local defaults = {
  noremap = true,
  silent = true,
  nowait = true,
}

---@class Map
---@field public map fun(mode: string, from: string, to: string | function, opt?: table | string): Map
---@field public map_with fun(mode: string, from: string, to: string, opt?: table<string, any>): Map
---@field public map_buffer fun(buffer: integer, mode: string, from: string, to: string, opt?: table<string, any>): Map
---@field public init fun(target: any): any
local M = {}
M.map = function(mode, from, to, opt)
  if type(opt) == "string" then
    opt = { desc = opt }
  else
    opt = opt or {}
  end
  opt = vim.tbl_deep_extend("force", {}, defaults, opt)
  if type(to) == "function" then
    vim.keymap.set(mode, from, to, opt)
  else
    vim.api.nvim_set_keymap(mode, from, to, opt)
  end
  return M
end

M.map_with = function(mode, from, to, opt)
  vim.api.nvim_set_keymap(mode, from, to, opt)
  return M
end

M.map_buffer = function(buffer, mode, from, to, opt)
  local defaults = {
    noremap = true,
    silent = true,
  }
  if type(opt) == "string" then
    opt = { desc = opt }
  else
    opt = opt or {}
  end
  opt = vim.tbl_deep_extend("force", {}, defaults, opt)
  vim.api.nvim_buf_set_keymap(buffer, mode, from, to, opt)
  return M
end

return {
  -- add window-picker
  {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
          require'window-picker'.setup()
      end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil , -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "+", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖",-- this can only be used in the git_status source
              renamed   = "󰁕",-- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            }
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = false,
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {
          system_open = function(state, callback)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.api.nvim_command('silent !open ' .. path)
          end
        },
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["o"] = "open",
            ["O"] = "open",
            ["<a-o>"] = "system_open",
            ["<a-O>"] = "system_open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            -- Read `# Preview Mode` for more information
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["<a-m>"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
            hide_by_name = {
              "node_modules",
              ".eden-mono",
              "log",
              "dist"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              ".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              -- ["<bs>"] = "navigate_up",
              -- ["."] = "set_root",
              -- ["H"] = "toggle_hidden",
              -- ["/"] = "fuzzy_finder",
              -- ["D"] = "fuzzy_finder_directory",
              ["/"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              ["<c-f>"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              -- ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              -- ["oc"] = { "order_by_created", nowait = false },
              -- ["od"] = { "order_by_diagnostics", nowait = false },
              -- ["og"] = { "order_by_git_status", nowait = false },
              -- ["om"] = { "order_by_modified", nowait = false },
              -- ["on"] = { "order_by_name", nowait = false },
              -- ["os"] = { "order_by_size", nowait = false },
              -- ["ot"] = { "order_by_type", nowait = false },
              -- ['<key>'] = function(state) ... end,
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ["<down>"] = "move_cursor_down",
              ["<C-j>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-k>"] = "move_cursor_up",
              -- ['<key>'] = function(state, scroll_padding) ... end,
            },
          },

          commands = {} -- Add a custom command or override a global one using the same function name
        },
        buffers = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              -- ["bd"] = "buffer_delete",
              -- ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              -- ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              -- ["oc"] = { "order_by_created", nowait = false },
              -- ["od"] = { "order_by_diagnostics", nowait = false },
              -- ["om"] = { "order_by_modified", nowait = false },
              -- ["on"] = { "order_by_name", nowait = false },
              -- ["os"] = { "order_by_size", nowait = false },
              -- ["ot"] = { "order_by_type", nowait = false },
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              -- ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              -- ["oc"] = { "order_by_created", nowait = false },
              -- ["od"] = { "order_by_diagnostics", nowait = false },
              -- ["om"] = { "order_by_modified", nowait = false },
              -- ["on"] = { "order_by_name", nowait = false },
              -- ["os"] = { "order_by_size", nowait = false },
              -- ["ot"] = { "order_by_type", nowait = false },
            }
          }
        }
      })
      -- vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end,
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<c-p>",
        LazyVim.telescope("files"),
        desc = "Find Files (Root Dir)",
      },
      -- {
      --   "<leader>,",
      --   "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      --   desc = "Switch Buffer",
      -- },
      { "<c-f>", LazyVim.telescope("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- find
      { "<c-e>", LazyVim.telescope("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      -- { "<leader>fc", LazyVim.telescope.config_files(), desc = "Find Config File" },
      -- { "<leader>ff", LazyVim.telescope("files"), desc = "Find Files (Root Dir)" },
      -- { "<leader>fF", LazyVim.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      -- { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      -- { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- { "<leader>fR", LazyVim.telescope("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sg", LazyVim.telescope("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sG", LazyVim.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", LazyVim.telescope("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
      { "<leader>sW", LazyVim.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<leader>sw", LazyVim.telescope("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sW", LazyVim.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
      { "<C-j>", "move_selection_next" },
      { "<C-k>", "move_selection_previous" },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
          vim.keymap.set("n", "K", "10gk", { desc = "Quick Move", buffer = buffer })
        end)
      end,
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } },
        init = function()
          local navbuddy = require("nvim-navbuddy")
          local actions = require("nvim-navbuddy.actions")
          navbuddy.setup({
            window = {
              border = "single", -- "rounded", "double", "solid", "none"
              -- or an array with eight chars building up the border in a clockwise fashion
              -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
              size = "60%", -- Or table format example: { height = "40%", width = "100%"}
              position = "50%", -- Or table format example: { row = "100%", col = "0%"}
              scrolloff = nil, -- scrolloff value within navbuddy window
              sections = {
                left = {
                  size = "20%",
                  border = nil, -- You can set border style for each section individually as well.
                },
                mid = {
                  size = "40%",
                  border = nil,
                },
                right = {
                  -- No size option for right most section. It fills to
                  -- remaining area.
                  border = nil,
                  preview = "leaf", -- Right section can show previews too.
                  -- Options: "leaf", "always" or "never"
                },
              },
            },
            node_markers = {
              enabled = true,
              icons = {
                leaf = "  ",
                leaf_selected = " → ",
                branch = " ",
              },
            },
            icons = {
              File = "󰈙 ",
              Module = " ",
              Namespace = "󰌗 ",
              Package = " ",
              Class = "󰌗 ",
              Method = "󰆧 ",
              Property = " ",
              Field = " ",
              Constructor = " ",
              Enum = "󰕘",
              Interface = "󰕘",
              Function = "󰊕 ",
              Variable = "󰆧 ",
              Constant = "󰏿 ",
              String = " ",
              Number = "󰎠 ",
              Boolean = "◩ ",
              Array = "󰅪 ",
              Object = "󰅩 ",
              Key = "󰌋 ",
              Null = "󰟢 ",
              EnumMember = " ",
              Struct = "󰌗 ",
              Event = " ",
              Operator = "󰆕 ",
              TypeParameter = "󰊄 ",
            },
            use_default_mappings = false, -- If set to false, only mappings set
            -- by user are set. Else default
            -- mappings are used for keys
            -- that are not set by user
            mappings = {
              ["<esc>"] = actions.close(), -- Close and cursor to original location
              ["q"] = actions.close(),

              ["j"] = actions.next_sibling(), -- down
              ["k"] = actions.previous_sibling(), -- up

              ["h"] = actions.parent(), -- Move to left panel
              ["l"] = actions.children(), -- Move to right panel
              ["0"] = actions.root(), -- Move to first panel
              ["v"] = actions.visual_name(), -- Visual selection of name
              ["V"] = actions.visual_scope(), -- Visual selection of scope

              ["y"] = actions.yank_name(), -- Yank the name to system clipboard "+
              ["Y"] = actions.yank_scope(), -- Yank the scope to system clipboard "+

              ["i"] = actions.insert_name(), -- Insert at start of name
              ["I"] = actions.insert_scope(), -- Insert at start of scope

              ["a"] = actions.append_name(), -- Insert at end of name
              ["A"] = actions.append_scope(), -- Insert at end of scope

              ["r"] = actions.rename(), -- Rename currently focused symbol

              ["d"] = actions.delete(), -- Delete scope

              ["f"] = actions.fold_create(), -- Create fold of current scope
              ["F"] = actions.fold_delete(), -- Delete fold of current scope

              ["c"] = actions.comment(), -- Comment out current scope

              ["<enter>"] = actions.select(), -- Goto selected symbol
              ["o"] = actions.select(),

              ["J"] = actions.move_down(), -- Move focused node down
              ["K"] = actions.move_up(), -- Move focused node up

              ["s"] = actions.toggle_preview(), -- Show preview of current node

              ["<C-v>"] = actions.vsplit(), -- Open selected node in a vertical split
              ["<C-s>"] = actions.hsplit(), -- Open selected node in a horizontal split

              ["t"] = actions.telescope({ -- Fuzzy finder at current level.
                layout_config = { -- All options that can be
                  height = 0.60, -- passed to telescope.nvim's
                  width = 0.60, -- default can be passed here.
                  prompt_position = "top",
                  preview_width = 0.50,
                },
                layout_strategy = "horizontal",
              }),

              ["g?"] = actions.help(), -- Open mappings help window
            },
            lsp = {
              auto_attach = true, -- If set to true, you don't need to manually use attach function
              preference = nil, -- list of lsp server names in order of preference
            },
            source_buffer = {
              follow_node = true, -- Keep the current node in focus on the source buffer
              highlight = true, -- Highlight the currently focused node
              reorient = "smart", -- "smart", "top", "mid" or "none"
              scrolloff = nil, -- scrolloff value when navbuddy is open
            },
            custom_hl_group = nil, -- "Visual" or any other hl group to use instead of inverted colors
          })
        end,
      }
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {
          keys = {
            { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
            { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
            { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
            { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
            { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
            { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
            { "K", "10gk", desc = "quick Move" },
            { "gh", vim.lsp.buf.hover, desc = "Hover" },
            { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
            { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
            { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
            { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
            {
              "<leader>cA",
              function()
                vim.lsp.buf.code_action({
                  context = {
                    only = {
                      "source",
                    },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Source Action",
              has = "codeAction",
            }
          },
          on_attach = function(_, buffer)
            local navbuddy = require("nvim-navbuddy")
            navbuddy.attach(_, buffer)
          end,
        },
        lua_ls = {
          keys = {
            { "K", "10gk", desc = "quick Move" },
          }
        }
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({
            server = opts,
          })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- 上一个
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- 出现补全
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- 取消
        ["<A-,>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        -- 确认
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
        }),
        -- 如果窗口内容太多，可以滚动
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      })
    end,
  },
  -- 补全引擎
  "hrsh7th/nvim-cmp",
  -- Snippet 引擎
  "hrsh7th/vim-vsnip",
  -- 补全源
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  -- 常见编程语言代码段
  "rafamadriz/friendly-snippets",

  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  "tpope/vim-abolish",
  "chaoren/vim-wordmotion",
}