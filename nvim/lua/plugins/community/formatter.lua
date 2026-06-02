return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = { 'n', 'v' },
      desc = '[C]ode [F]ormat',
    },
  },
  opts = {
    formatters_by_ft = {},
  },
  config = function(_, opts)
    require('conform').setup(opts)
  end,
}
