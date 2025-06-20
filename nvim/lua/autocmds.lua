-- autocmds.lua

local api = vim.api

-- augroupで自動コマンドをグループ化して再読み込み時に重複しないようにする
local custom_autocmds = api.nvim_create_augroup("CustomAutoCmds", { clear = true })

-- 全てのファイルタイプでoやOによるコメントの自動挿入を無効化
api.nvim_create_autocmd("FileType", {
  pattern = "*",
  group = custom_autocmds,
  desc = "Disable auto-commenting on new line",
  callback = function()
    vim.opt_local.formatoptions:remove "o"
  end,
})
