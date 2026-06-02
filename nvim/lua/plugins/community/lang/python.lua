return {
  { 'neovim/nvim-lspconfig', opts = { servers = { pyright = {} } } },
  { 'stevearc/conform.nvim', opts = { formatters_by_ft = { python = { 'ruff_format' } } } },
  { 'mfussenegger/nvim-lint', opts = { linters_by_ft = { python = { 'ruff' } } } },
}
