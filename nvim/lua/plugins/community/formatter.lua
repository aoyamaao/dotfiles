return {
  'stevearc/conform.nvim',
  lazy = false,
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        cpp = { 'clang-format' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        astro = { 'prettier' },
      },
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      require('conform').format({ async = true, lsp_fallback = true })
    end, { desc = '[C]ode [F]ormat' })
  end,
}
