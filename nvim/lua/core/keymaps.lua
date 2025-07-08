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
-- ノーマルモードのまま空行を挿入
map('n', '<Leader>o', 'o<Esc>')
map('n', '<Leader>O', 'O<Esc>')
-- 全選択
map('n', '<Leader>a', 'ggVG', { desc = 'Select All' })

-- --- Buffer & Window Navigation ---
-- バッファ移動
map('n', '<S-l>', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-h>', '<Cmd>bprevious<CR>', { desc = 'Previous buffer' })

-- ターミナルモードでウィンドウ移動
vim.cmd([[
  tnoremap <C-j> <C-w><C-j>
  tnoremap <C-k> <C-w><C-k>
  tnoremap <C-l> <C-w><C-l>
  tnoremap <C-h> <C-w><C-h>
]])
