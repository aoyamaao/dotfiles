return {
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { clangd = { cmd = { 'clangd', '--clang-tidy' } } } },
  },
  {
    'stevearc/conform.nvim',
    opts = { formatters_by_ft = { c = { 'clang-format' }, cpp = { 'clang-format' } } },
  },
  -- clangdがclang-tidy診断を出すのでlinterは不要
}
