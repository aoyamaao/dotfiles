return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
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
    })

    telescope.load_extension('fzf')

    local map = vim.keymap.set
    map('n', '<leader>lf', '<cmd>Telescope find_files<cr>', { desc = '[L]ookup [F]iles' })
    map('n', '<leader>lg', '<cmd>Telescope live_grep<cr>', { desc = '[L]ookup by [G]rep' })
    map('n', '<leader>lb', '<cmd>Telescope buffers<cr>', { desc = '[L]ookup [B]uffers' })
    map('n', '<leader>lh', '<cmd>Telescope help_tags<cr>', { desc = '[L]ookup [H]elp' })
    map('n', '<leader>ld', '<cmd>Telescope diagnostics<cr>', { desc = '[L]ookup [D]iagnostics' })
  end,
}
