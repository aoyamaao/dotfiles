return {
  'tpope/vim-fugitive',
  cmd = { 'G', 'Git' },
  keys = {
    { '<leader>g', group = 'Git' },
    -- Git Status
    { '<leader>gs', '<cmd>G<cr>', desc = 'Status' },
    -- Git Add
    { '<leader>ga', '<cmd>G add .<cr>', desc = 'Add all' },
    { '<leader>gp', '<cmd>G add %<cr>', desc = 'Add current file' },
    -- Git Commit
    { '<leader>gc', '<cmd>G commit<cr>', desc = 'Commit' },
    { '<leader>gca', '<cmd>G commit -a<cr>', desc = 'Commit all' },
    -- Git Diff
    { '<leader>gd', '<cmd>Gdiffsplit<cr>', desc = 'Diff' },
    { '<leader>gds', '<cmd>Gdiffsplit --staged<cr>', desc = 'Diff Staged' },
    -- Git Log
    { '<leader>gl', '<cmd>G log<cr>', desc = 'Log' },
    { '<leader>gL', '<cmd>G log --graph --oneline --decorate --all<cr>', desc = 'Log (Graph)' },
    -- Git Push
    { '<leader>gp', group = 'Push' },
    { '<leader>gpp', '<cmd>G push<cr>', desc = 'Push' },
    { '<leader>gpf', '<cmd>G push --force-with-lease<cr>', desc = 'Push (Force with lease)' },
  },
}
