return {
  { 'neovim/nvim-lspconfig', opts = { servers = { yamlls = {} } } },
  { 'stevearc/conform.nvim', opts = { formatters_by_ft = { yaml = { 'prettier' } } } },
  { 'mfussenegger/nvim-lint', opts = { linters_by_ft = { yaml = { 'yamllint' } } } },
}
