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
        file_ignore_patterns = { 'node_modules', '.git/', 'dist/' },
      },
      pickers = {
        registers = { theme = 'cursor' },
        diagnostics = { theme = 'ivy' },
        find_files = {
          find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' },
        },
        buffers = {
          theme = 'dropdown',
          mappings = {
            i = {
              ['<C-x>'] = actions.delete_buffer,
            },
            n = {
              ['<C-x>'] = actions.delete_buffer,
            },
          },
        },
        -- gitは全て閲覧専用 (破壊的キーを封じる)
        git_status = {
          theme = 'ivy',
          mappings = {
            i = { ['<Tab>'] = false },
            n = { ['<Tab>'] = false },
          },
        },
        git_commits = {
          mappings = {
            i = { ['<CR>'] = false, ['<C-r>m'] = false, ['<C-r>s'] = false, ['<C-r>h'] = false },
            n = { ['<CR>'] = false },
          },
        },
        git_bcommits = {
          mappings = {
            i = { ['<CR>'] = false },
            n = { ['<CR>'] = false },
          },
        },
        git_branches = {
          mappings = {
            i = {
              ['<CR>'] = false,
              ['<C-t>'] = false,
              ['<C-r>'] = false,
              ['<C-a>'] = false,
              ['<C-d>'] = false,
              ['<C-y>'] = false,
            },
            n = { ['<CR>'] = false },
          },
        },
      },
    })
    telescope.load_extension('fzf')

    local map = vim.keymap.set
    -- 検索・移動
    map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '[F]ind [F]iles' })
    map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = '[F]ind by [G]rep' })
    map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = '[F]ind [B]uffers' })
    map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = '[F]ind [H]elp' })
    map('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { desc = '[F]ind [D]iagnostics' })
    map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = '[F]ind [O]ldfiles' })
    map('n', '<leader>fw', '<cmd>Telescope grep_string<cr>', { desc = '[F]ind [W]ord' })
    map('n', '<leader>fr', '<cmd>Telescope resume<cr>', { desc = '[F]ind [R]esume' })
    map('n', '<leader>fp', '<cmd>Telescope registers<cr>', { desc = '[F]ind register ([P]aste)' })
    map('n', '<leader>fk', '<cmd>Telescope keymaps<cr>', { desc = '[F]ind ([K]eymaps)' })
    map('n', '<leader>fc', '<cmd>Telescope commands<cr>', { desc = '[F]ind ([C]ommands)' })
    -- git (閲覧専用)
    map('n', '<leader>gs', '<cmd>Telescope git_status<cr>', { desc = 'Git status' })
    map('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', { desc = 'Git commits' })
    map('n', '<leader>gC', '<cmd>Telescope git_bcommits<cr>', { desc = 'Git commits (this file)' })
  end,
}
