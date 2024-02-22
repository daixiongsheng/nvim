local status, mode = pcall(require, "dummy-coder")
if not status then
  vim.notify("没有找到 mode")
  return
end
mode.setup({
  -- 是否在 command line area 打印过程信息
  print_info = true,
  enable = true,
  plugins = {
    code_gen = {
      enable = true,
      max_context_range = 80,
      max_suffix_range = 5,
      treesitter = {
        enable = true,
        -- treesitter 从当前节点向上找寻 parent 的最大深度
        -- 如果 treesitter 在从当前节点向上遍历时遇到的节点不在 consider_context_types 中
        -- 便会继续向上遍历，直到超出 max_depth
        -- The maximum depth of the parent from the current node upwards
        -- If the treesitter encounters a node whose type wasn't in consider_context_types
        -- Will continue to traverse upwards until the searching depth exceeds max_depth
        max_depth = 10,
        -- treesitter 会加入 context 考虑的上下文
        -- treesitter node types that will be considered as context
        consider_context_types = {
          'declaration',
          'comment',
          'block',
        },
      },
      -- vim 获得的 file_type 到 codeverse 支持的语言的映射
      -- 没找到对应的文档，所以可能得自己尝试一下
      -- Mapping of file_type obtained by vim to languages supported by codeverse
      -- I didn't find the corresponding document about which languages
      -- codevere supports so you may have to try it myself.
      filetype_to_language = default_file_extention_to_language,
      -- 哪些 filetype 下的代码片段需要被 CodeGen 插件处理
      -- 默认为 filetype_to_language 中的 key
      -- 设置会 覆盖 而不是 合并
      -- 如果想要 "增加" 某个文件类型，建议配置 filetyoe_to_language
      -- Which code snippets under filetype need to be processed by the CodeGen.
      -- defaulting to the keys in filetype_to_language
      -- Settings will be overwritten instead of merged.
      -- If you want to "increase" a file type, it is recommended to configure filetyoe_to_language
      enable_filetype = nil,
    },
  },
  log = {
    file = '', --filename you want to setup your log, if unset or '', dummycoder will initiate a default one
    min_level = 'INFO', --TRACE, DEBUG, INFO, WARN, ERROR
    auto_clear = false, -- if true, dummycoder will try to clean last time's log file at next start
  },
  cacheConfig = {
    -- dir you want to place your login-related token
    config_dir = default_cache_config_dir,
  },
  agent = {
    timeout = {
      login = default_request_timeout_mssec,
      code_gen = default_request_timeout_mssec,
      login_check = default_request_timeout_mssec,
      get_jwt_token = default_request_timeout_mssec,
      get_cas_session_cookie = default_request_timeout_mssec,
    },
  },
  mappings = {
    DummyCoderLogin = nil,
    DummyCoderLog = nil,
    DummyCoderTokenConfig = nil,
    DummyCoderComplete = { n = '<leader><C-t>', i = '<leader><C-t>' },
    DummyCoderAccept = { i = '<C-]>', n = '<C-]>' },
    DummyCoderDisable = nil,
    DummyCoderEnable = nil,
    DummyCoderDisableBuffer = nil,
    DummyCoderEnableBuffer = nil
  },
})


--- 配置中涉及的默认变量如下
local default_cache_config_dir = (os.getenv('XDG_CONFIG_HOME') or os.getenv('HOME')) .. '/.config/dummycoder.nvim'
local config_loaded = false
local default_request_timeout_mssec = 30000

local default_file_extention_to_language = {
  python = 'py',
  typescriptreact = 'tsx',
  javascriptreact = 'jsx',
  javascript = 'js',
  typescript = 'ts',
  cpp = 'cpp',
  c = 'c',
  go = 'golang',
  racket = 'racket',
  lua = 'lua',
  rust = 'rs',
  scheme = 'scheme',
  java = 'java',
  scala = 'scala',
  cs = 'cs',
  json = 'json',
}
