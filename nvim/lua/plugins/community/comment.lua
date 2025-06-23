return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()

    local map = vim.keymap.set
    -- ノーマルモードで gcc と打つと、現在の行をコメントアウト/解除
    map(
      'n',
      'gcc',
      '<Plug>(comment_toggle_linewise_current)',
      { desc = 'Toggle comment on current line' }
    )
    -- ビジュアルモードで選択した範囲をコメントアウト/解除
    map(
      'v',
      'gc',
      '<Plug>(comment_toggle_linewise_visual)',
      { desc = 'Toggle comment on visual selection' }
    )
  end,
}
