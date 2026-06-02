return {
  { 'neovim/nvim-lspconfig', opts = { servers = { lua_ls = {} } } },
  { 'stevearc/conform.nvim', opts = { formatters_by_ft = { lua = { 'stylua' } } } },
  { 'mfussenegger/nvim-lint', opts = { linters_by_ft = { lua = { 'luacheck' } } } },
}
