local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到 null-ls")
  return
end

-- local eslint = require("lspconfig.eslint")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion

null_ls.setup({
  debug = false,
  sources = {
    -- Formatting ---------------------
    --  brew install shfmt
    formatting.shfmt,
    -- StyLua
    formatting.stylua,
    -- frontend
    formatting.prettier.with({
      -- 比默认少了 markdown
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "graphql",
      },
    }),
    -- rustfmt
    -- rustup component add rustfmt
    formatting.rustfmt,
    -- Python
    -- pip install black
    -- asdf reshim python
    formatting.black.with({ extra_args = { "--fast" } }),
    -- formatting.eslint_d,
    -- diagnostics.eslint_d,
    -- code_actions.eslint_d,
    -----------------------------------------------------
    -- Ruby
    -- gem install rubocop
    -- formatting.rubocop,
    -----------------------------------------------------
    -- formatting.fixjson,
    -- Diagnostics  ---------------------
    -- diagnostics.eslint.with({
    --   prefer_local = "node_modules/.bin",
    -- }),
    -- diagnostics.markdownlint,
    -- markdownlint-cli2
    -- diagnostics.markdownlint.with({
    --   prefer_local = "node_modules/.bin",
    --   command = "markdownlint-cli2",
    --   args = { "$FILENAME", "#node_modules" },
    -- }),
    --
    -- completion.spell,
    -- formatting.codespell,
    -- code_actions.cspell,
    -- diagnostics.cspell,
    -- diagnostics.codespell,
    -- diagnostics.eslint,
    -- code actions ---------------------
    code_actions.gitsigns,
    -- code_actions.eslint_d,
    code_actions.impl,
    code_actions.refactoring,
    code_actions.xo,
    -- completion.spell,
    -- code_actions.eslint.with({
    --   prefer_local = "/Users/bytedance/Documents/project/bytedance/slide/infra/node_modules/.bin ",
    -- }),
  },
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  diagnostics_format = "[#{s}] #{m}",
  on_attach = function(_)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
    -- if client.server_capabilities.document_formatting then
    --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    -- end
  end,
})
-- eslint.setup({
--   bin = "eslint_d", -- or `eslint_d`
--   code_actions = {
--     enable = true,
--     apply_on_save = {
--       enable = true,
--       types = { "directive", "problem", "suggestion", "layout" },
--     },
--     disable_rule_comment = {
--       enable = true,
--       location = "separate_line", -- or `same_line`
--     },
--   },
--   diagnostics = {
--     enable = true,
--     report_unused_disable_directives = false,
--     run_on = "type", -- or `save`
--   },
-- })
