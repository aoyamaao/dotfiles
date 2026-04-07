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
          'mdx',
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
          'mdx',
        }
      end
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'mdx' },
    opts = {
      file_types = { 'markdown', 'mdx' },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'markdown', 'mdx' },
        callback = function(event)
          vim.keymap.set(
            'n',
            '<Leader>k',
            '"zciW[<C-r>z](<C-r>+)<Esc>',
            { buffer = event.buf, desc = '単語をMarkdownリンク化' }
          )
          vim.keymap.set(
            'v',
            '<Leader>k',
            '"zc[<C-r>z](<C-r>+)<Esc>',
            { buffer = event.buf, desc = '選択範囲をMarkdownリンク化' }
          )
        end,
      })
    end,
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
