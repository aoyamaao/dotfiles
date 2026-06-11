return {
  { 'neovim/nvim-lspconfig', opts = { servers = { nixd = {} } } },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = { nix = { 'nixfmt' } },
      formatters = {
        nixfmt = {
          command = 'nixfmt',
          args = { '-' },
          stdin = true,
        },
      },
    },
  },
  { 'mfussenegger/nvim-lint', opts = { linters_by_ft = { nix = { 'statix' } } } },
}
