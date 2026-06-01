return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'williamboman/mason.nvim',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'b0o/schemastore.nvim' },
    config = function()
      local lsp_core = require('core.lsp')
      local servers = { 'lua_ls', 'pyright', 'clangd', 'astro', 'ts_ls', 'jsonls' }

      vim.lsp.config('*', {
        on_attach = lsp_core.on_attach,
        capabilities = lsp_core.capabilities,
      })

      vim.lsp.config('jsonls', {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })

      for _, server_name in ipairs(servers) do
        vim.lsp.enable(server_name)
      end
    end,
  },
}
