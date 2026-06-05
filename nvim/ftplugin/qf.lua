-- Quickfix / Location listをバッファ一覧から除外
vim.opt_local.buflisted = false

vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = true })
