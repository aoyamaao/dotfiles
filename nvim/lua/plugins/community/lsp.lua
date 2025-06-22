return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    init = function()
      -- LSP関連の診断(diagnostic)の記号を無効化
      vim.diagnostic.config({
        signs = false,
        virtual_text = false,
      })
    end,
  },

  {
    'williamboman/mason.nvim',
    lazy = true,
    config = true,
  },

  -- masonとlspconfigを連携させるためのプラグイン
  {
    'williamboman/mason-lspconfig.nvim',
  },

  -- LSP設定
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      {
        'antosha417/nvim-lsp-file-operations',
        config = true,
        dependencies = {
          'nvim-lua/plenary.nvim',
        },
      },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.on_attach(function(client, bufnr)
        -- LSPの機能を有効にするキーマッピング
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)
      lsp_zero.extend_lspconfig()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'pyright', 'clangd' },
        handlers = {
          lsp_zero.default_setup,
        },
      })
    end,
  },

  -- コード補完
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function()
      local cmp = require('cmp')
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      cmp.setup({
        -- 補完ソース
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
        -- キーマッピング
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        },
      })
    end,
  },

  -- スニペット
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    dependencies = { 'saadparwaiz1/cmp_luasnip' },
    -- スニペットエンジンの設定
    config = function()
      local luasnip = require('luasnip')
      luasnip.config.setup({})
    end,
  },
}
