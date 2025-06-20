-- lua/options.lua

local opt = vim.opt

-- 行番号を表示する
opt.number = true

-- 相対行番号を表示する (<N>j, <N>kでの移動が楽になる)
opt.relativenumber = true

-- 無名レジスタとシステムクリップボードを同期させる
opt.clipboard = "unnamedplus"
