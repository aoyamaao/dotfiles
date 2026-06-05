return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'markdown',
        'markdown_inline',
        'latex',
        'astro',
        'html',
        'css',
        'javascript',
        'typescript',
        'tsx',
        'lua',
        'vim',
        'vimdoc',
        'query',
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'mdx' },
    opts = {
      file_types = { 'markdown', 'mdx' },
      latex = {
        enabled = true,
        converter = { 'latex2text' },
      },
    },
  },
  {
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown', 'mdx' },
    config = function()
      -- Markdown標準のテーブル構文にする
      vim.g.table_mode_corner = '|'

      -- <Leader>| でテーブルモードのON/OFFを切り替え
      vim.keymap.set('n', '<leader>|', '<cmd>TableModeToggle<CR>', { desc = 'Toggle Table Mode' })
    end,
  },
}
