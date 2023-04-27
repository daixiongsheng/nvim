-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  paccker_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })

  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("没有安装 packer.nvim")
  return
end

packer.startup({
  function(use)
    -- Packer 可以升级自己
    use("wbthomason/packer.nvim")
    -------------------------- plugins -------------------------------------------
    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = {
        "nvim-tree/nvim-web-devicons",
        "famiu/bufdelete.nvim",
      },
    })
    -- lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "nvim-tree/nvim-web-devicons", opt = true },
    })
    -- nvim-web-devicons
    use("nvim-tree/nvim-web-devicons")
    use("arkav/lualine-lsp-progress")
    use("gbprod/yanky.nvim")
    -- telescope
    use({
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    })
    -- telescope extensions
    use("LinArcX/telescope-env.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")
    -- notify
    use({
      "rcarriga/nvim-notify",
      requires = {
        "neovim/nvim-lspconfig",
      },
    })
    -- nvim-tree
    use({
      "nvim-tree/nvim-tree.lua",
      requires = "nvim-tree/nvim-web-devicons",
    })
    -- treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    })
    use({
      "williamboman/mason.nvim",
      run = ":MasonUpdate", -- :MasonUpdate updates registry contents
    })
    use("p00f/nvim-ts-rainbow")
    -- indent-blankline
    use("lukas-reineke/indent-blankline.nvim")
    use("ethanholz/nvim-lastplace")

    -- git
    -- fugitive
    use({
      "tpope/vim-fugitive",
      cmd = {
        "G",
        "Git",
        "Gdiff",
        "Gdiffsplit",
        "Gread",
        "Gwrite",
        "Ggrep",
        "GMove",
        "GDelete",
        "GBrowse",
        "GRemove",
        "GRename",
        "Glgrep",
        "Gedit",
      },
      ft = { "fugitive" },
    })

    use({ "tpope/vim-repeat" })
    use({ "styled-components/vim-styled-components" })
    use({ "terryma/vim-expand-region" })
    use({ "bronson/vim-trailing-whitespace" })

    --------------------- LSP --------------------
    use({ "williamboman/nvim-lsp-installer" })
    -- Lspconfig
    use({
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
      },
    })
    use({
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig",
    })
    use({
      "SmiteshP/nvim-navbuddy",
      requires = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
    })
    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- Snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")
    -- UI 增强
    use("onsails/lspkind-nvim")
    use("folke/neodev.nvim")
    use("tami5/lspsaga.nvim")
    -- 代码格式化
    use("mhartington/formatter.nvim")
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    -- TypeScript 增强
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })
    -- Lua 增强
    use("folke/lua-dev.nvim")
    -- JSON 增强
    use("b0o/schemastore.nvim")
    -- Rust 增强
    use("simrat39/rust-tools.nvim")
    --------------------- colorschemes --------------------
    use("lunarvim/colorschemes")
    -- tokyonight
    use("folke/tokyonight.nvim")
    -- OceanicNext
    use("mhartington/oceanic-next")
    -- gruvbox
    use({
      "ellisonleao/gruvbox.nvim",
      requires = { "rktjmp/lush.nvim" },
    })
    -- zephyr
    use("glepnir/zephyr-nvim")
    -- nord
    use("shaunsingh/nord.nvim")
    -- onedark
    use("ful1e5/onedark.nvim")
    -- nightfox
    use("EdenEast/nightfox.nvim")

    -------------------------------------------------------
    use({ "akinsho/toggleterm.nvim" })
    -- surround
    use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    })
    use({
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
    })
    use({
      "famiu/feline.nvim",
    })
    -- Comment
    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("windwp/nvim-ts-autotag")
    use("RRethy/nvim-treesitter-textsubjects")
    -- conflict
    use({
      "rhysd/conflict-marker.vim",
    })
    -- nvim-autopairs
    use("windwp/nvim-autopairs")
    -- git
    use({ "lewis6991/gitsigns.nvim" })
    use({
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
    })
    use({
      "folke/which-key.nvim",
    })
    ----------------------------------------------
    use("mfussenegger/nvim-dap")
    use("theHamsta/nvim-dap-virtual-text")
    use({
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
    })
    use("jbyuki/one-small-step-for-vimkind")
    -- search
    use({
      "windwp/nvim-spectre",
      requires = "nvim-lua/plenary.nvim",
    })
    use({
      "j-hui/fidget.nvim",
    })
    use("LunarVim/onedarker")
    use("mattkubej/jest.nvim")

    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
    })
    use({
      "smjonas/inc-rename.nvim",
    })
    use({
      "notjedi/nvim-rooter.lua",
    })
    use({
      "dnlhc/glance.nvim",
    })
    use("fedepujol/move.nvim")
    use("ms-jpq/coq_nvim")
    use("brenoprata10/nvim-highlight-colors")
    use("tpope/vim-abolish")
    use("chaoren/vim-wordmotion")

    if paccker_bootstrap then
      packer.sync()
    end
  end,
  -- config = {
  --   -- 锁定插件版本在snapshots目录
  --   -- snapshot_path = require('packer.util').join_paths(vim.fn.stdpath('config'), 'snapshots'),
  --   -- 这里锁定插件版本在v1，不会继续更新插件
  --   -- snapshot = 'v1',
  --   -- 最大并发数
  --   max_jobs = 16,
  --   display = {
  --     -- 使用浮动窗口显示
  --     open_fn = function()
  --       return require('packer.util').float({ border = 'single' })
  --     end,
  --   },
  -- },
})
