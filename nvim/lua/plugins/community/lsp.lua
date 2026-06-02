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
    opts = {
      servers = {},
    },
    config = function(_, opts)
      local lsp_core = require('core.lsp')

      vim.lsp.config('*', {
        on_attach = lsp_core.on_attach,
        capabilities = lsp_core.capabilities,
      })

      for name, cfg in pairs(opts.servers) do
        if next(cfg) ~= nil then
          vim.lsp.config(name, cfg)
        end
        vim.lsp.enable(name)
      end
    end,
  },
}
