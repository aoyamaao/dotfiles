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
}
