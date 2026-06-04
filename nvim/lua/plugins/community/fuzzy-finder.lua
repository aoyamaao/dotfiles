return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<Esc>'] = actions.close,
          },
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ['<C-x>'] = actions.delete_buffer,
            },
          },
        },
      },
    })
    telescope.load_extension('fzf')

    local map = vim.keymap.set
    map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '[F]ind [F]iles' })
    map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = '[F]ind by [G]rep' })
    map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = '[F]ind [B]uffers' })
    map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = '[F]ind [H]elp' })
    map('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { desc = '[F]ind [D]iagnostics' })
  end,
}
