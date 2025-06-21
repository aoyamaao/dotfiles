-- autocmds.lua

local api = vim.api

-- augroupで自動コマンドをグループ化して再読み込み時に重複しないようにする
local custom_autocmds = api.nvim_create_augroup('CustomAutoCmds', { clear = true })

-- 全てのファイルタイプでoやOによるコメントの自動挿入を無効化
api.nvim_create_autocmd('FileType', {
  pattern = '*',
  group = custom_autocmds,
  desc = 'Disable auto-commenting on new line',
  callback = function()
    vim.opt_local.formatoptions:remove('o')
  end,
})

-- LuaとVimScriptはインデント幅を2にする
api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'vim' },
  group = custom_autocmds,
  desc = 'Set indent width to 2 for lua and vim files',
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- 保存時に自動でフォーマットを実行する
local format_on_save_group = api.nvim_create_augroup('FormatOnSave', { clear = true })
api.nvim_create_autocmd('BufWritePre', {
  group = format_on_save_group,
  pattern = '*',
  desc = 'Format buffer before saving',
  callback = function(args)
    local conform = require('conform')

    -- 戻り値で、フォーマットによって変更があったか(true)なかったか(nil)を取得。
    local formatted = conform.format({
      bufnr = args.buf,
      lsp_fallback = true,
    })

    -- 実際に変更があった場合のみ通知を出す
    if formatted then
      -- vim.scheduleを使って現在の保存処理が終わった直後に通知を実行
      vim.schedule(function()
        vim.notify(
          'Auto format complete! ' .. vim.fn.bufname(args.buf),
          vim.log.levels.INFO,
          { title = 'Conform' }
        )
      end)
    end
  end,
})
