return {
  -- =================================================================
  -- 1. Mason
  -- =================================================================
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  -- =================================================================
  -- 2. Mason LSP-Config
  -- =================================================================
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      -- インストール済みのLSPサーバーを管理し、セットアップの準備をする
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'pyright', 'clangd' },
      })
    end,
  },

  -- =================================================================
  -- 3. nvim-lspconfig
  -- =================================================================
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set(
            'n',
            keys,
            func,
            { buffer = bufnr, noremap = true, silent = true, desc = desc }
          )
        end
        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('gl', vim.diagnostic.open_float, 'Line Diagnostics')
      end
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
          ['lua_ls'] = function()
            require('lspconfig').lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { 'vim' } },
                },
              },
            })
          end,
        },
      })
    end,
  },

  -- =================================================================
  -- 4. nvim-cmp (コード補完UI)
  -- =================================================================
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' },
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
      })
    end,
  },
}
