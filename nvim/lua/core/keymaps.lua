-- keymaps.lua

--==============================================================================
-- Functions
--==============================================================================

-- キーマッピングをより簡単に設定するためのヘルパー関数
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

--==============================================================================
-- Leader Key
--==============================================================================
-- <Leader>キーをSpaceに設定
vim.g.mapleader = ' '

--==============================================================================
-- General Mappings
--==============================================================================

-- --- Basic Convenience ---
-- Insertモードから抜ける
map('i', 'jj', '<Esc>')

-- 保存、閉じる、保存して閉じる
map('n', '<Leader>w', '<Cmd>w<CR>', { desc = 'Write (save) the file' })
map('n', '<Leader>q', '<Cmd>q<CR>', { desc = 'Quit the current window' })
map('n', '<Leader>qq', '<Cmd>q!<CR>', { desc = 'Quit without saving' })
map('n', '<Leader>wq', '<Cmd>wq<CR>', { desc = 'Write and quit' })

-- Escキー4回で検索ハイライトを消去
map('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- --- Editing Helpers ---
-- ノーマルモードのまま空行を挿入し、カーソルは移動させない
map('n', '<Leader>o', 'm`o<Esc>``')
map('n', '<Leader>O', 'm`O<Esc>``')
-- 全選択
map('n', '<Leader>a', 'ggVG', { desc = 'Select All' })
-- 行移動
map('n', '<A-k>', '<Cmd>m .-2<CR>==', { desc = '現在の行を上に移動' })
map('n', '<A-j>', '<Cmd>m .+1<CR>==', { desc = '現在の行を下に移動' })

-- --- Buffer & Window Navigation ---
map('n', '<S-l>', '<Cmd>bnext<CR>', { desc = '次のBufferへ移動' })
map('n', '<S-h>', '<Cmd>bprevious<CR>', { desc = '前のBufferへ移動' })
map('n', '<Leader>bd', '<Cmd>bp | bd #<CR>', { desc = 'Bufferを閉じる' })
map('n', '<leader>bn', '<cmd>enew<cr>', { desc = '空のBufferを新規作成' })
map('n', '<leader>br', '<cmd>%bd<cr>', { desc = 'すべてのBufferを閉じる' })
map('n', '<leader>bc', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local all_bufs = vim.api.nvim_list_bufs()
  local count = 0

  for _, buf in ipairs(all_bufs) do
    -- 1. 現在のバッファではない
    -- 2. かつ、有効なバッファである
    -- 3. かつ、リストに表示される設定になっている（buflisted）
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      -- 未保存の変更がある場合は削除をスキップ（安全のため）
      local success, _ = pcall(vim.api.nvim_buf_delete, buf, { force = false })
      if success then
        count = count + 1
      end
    end
  end

  if count > 0 then
    vim.notify(
      count .. ' 個のBufferを削除しました',
      vim.log.levels.INFO,
      { title = 'Buffer掃除' }
    )
  else
    vim.notify(
      '削除できる他のBufferはありません',
      vim.log.levels.WARN,
      { title = 'Buffer掃除' }
    )
  end
end, { desc = '現在のBuffer以外をすべて閉じる' })

-- --- Markdown ---
map('n', '<Leader>k', '"zciW[<C-r>z](<C-r>+)<Esc>', { desc = '単語をMarkdownリンク化' })
map('v', '<Leader>k', '"zc[<C-r>z](<C-r>+)<Esc>', { desc = '選択範囲をMarkdownリンク化' })

-- ターミナルモードでウィンドウ移動
vim.cmd([[
  tnoremap <C-j> <C-w><C-j>
  tnoremap <C-k> <C-w><C-k>
  tnoremap <C-l> <C-w><C-l>
  tnoremap <C-h> <C-w><C-h>
]])
