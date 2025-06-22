return {
  'christoomey/vim-tmux-navigator',
  event = 'VeryLazy',
  keys = {
    { '<c-h>', '<cmd>TNavigateLeft<cr>', desc = 'Navigate Left (tmux)' },
    { '<c-j>', '<cmd>TNavigateDown<cr>', desc = 'Navigate Down (tmux)' },
    { '<c-k>', '<cmd>TNavigateUp<cr>', desc = 'Navigate Up (tmux)' },
    { '<c-l>', '<cmd>TNavigateRight<cr>', desc = 'Navigate Right (tmux)' },
  },
}
