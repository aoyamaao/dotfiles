return {
  'stevearc/conform.nvim',
  lazy = false,
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        cpp = { 'clang-format' },
      },
    })
    vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
      require('conform').format({ async = true, lsp_fallback = true })
      vim.notify('Manual format complete!', vim.log.levels.INFO, { title = 'Conform' })
    end, { desc = 'Format buffer' })
  end,
}
