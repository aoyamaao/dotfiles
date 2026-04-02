return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'markdown',
          'markdown_inline',
          'astro',
          'html',
          'css',
          'javascript',
          'typescript',
          'tsx',
        })
      else
        opts.ensure_installed = {
          'markdown',
          'markdown_inline',
          'astro',
          'html',
          'css',
          'javascript',
          'typescript',
          'tsx',
        }
      end
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    opts = {},
  },
  {
    'dhruvasagar/vim-table-mode',
    ft = 'markdown',
    config = function()
      -- Markdown標準のテーブル構文にする
      vim.g.table_mode_corner = '|'

      -- <Leader>| でテーブルモードのON/OFFを切り替え
      vim.keymap.set('n', '<leader>|', '<cmd>TableModeToggle<CR>', { desc = 'Toggle Table Mode' })
    end,
  },
}
