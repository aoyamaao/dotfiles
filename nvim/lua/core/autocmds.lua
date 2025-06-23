--=================================================================
-- autocmds.lua
--=================================================================
local api = vim.api

-- augroupで自動コマンドをグループ化して再読み込み時に重複しないようにする
local custom_autocmds = api.nvim_create_augroup('CustomAutoCmds', { clear = true })

--=================================================================
-- oコマンドのコメント自動挿入を無効化
--=================================================================
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

--=================================================================
-- 自動フォーマット
--=================================================================
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

--=================================================================
-- IME自動切り替え
--=================================================================
if vim.fn.has('mac') == 1 then
  vim.g.original_ime = ''

  local function on_focus_gained()
    local current_ime = vim.fn.trim(vim.fn.system('im-select'))
    if current_ime ~= 'com.apple.keylayout.ABC' then
      vim.g.original_ime = current_ime
    else
      vim.g.original_ime = ''
    end
    vim.fn.system('im-select com.apple.keylayout.ABC')
  end

  local function on_focus_lost()
    if vim.g.original_ime ~= '' and vim.g.original_ime ~= 'com.apple.keylayout.ABC' then
      vim.fn.system('im-select ' .. vim.g.original_ime)
      vim.g.original_ime = ''
    end
  end

  local ime_augroup = vim.api.nvim_create_augroup('ImeAutoSwitch', { clear = true })
  vim.api.nvim_create_autocmd({ 'FocusGained', 'WinEnter' }, {
    group = ime_augroup,
    pattern = '*',
    callback = on_focus_gained,
  })
  vim.api.nvim_create_autocmd({ 'FocusLost', 'WinLeave' }, {
    group = ime_augroup,
    pattern = '*',
    callback = on_focus_lost,
  })
end
