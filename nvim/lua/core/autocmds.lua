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
  pattern = { 'lua', 'vim', 'cpp' },
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
  local ime_augroup = vim.api.nvim_create_augroup('ImeAutoSwitch', { clear = true })

  -- Inserモード時のIME状態を記憶
  local saved_ime = 'com.apple.keylayout.ABC'

  -- Insertモードを抜ける時
  vim.api.nvim_create_autocmd('InsertLeave', {
    group = ime_augroup,
    callback = function()
      -- 現在のIME状態を保存する
      saved_ime = vim.fn.trim(vim.fn.system('im-select'))

      -- 日本語等の場合、強制的に英語に戻す
      if saved_ime ~= 'com.apple.keylayout.ABC' then
        -- os.executeの末尾に '&' をつけてバックグラウンド実行
        os.execute('im-select com.apple.keylayout.ABC > /dev/null 2>&1 &')
      end
    end,
  })

  -- Insertモードに入る時
  vim.api.nvim_create_autocmd('InsertEnter', {
    group = ime_augroup,
    callback = function()
      -- 前回Insertモードだった時のIME状態に復元する
      if saved_ime ~= 'com.apple.keylayout.ABC' then
        os.execute('im-select ' .. saved_ime .. ' > /dev/null 2>&1 &')
      end
    end,
  })
end

-- =================================================================
-- AtCoderプロジェクト用のclangd設定を自動生成する
-- =================================================================
local atcoder_project_augroup = vim.api.nvim_create_augroup('AtcoderProject', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = atcoder_project_augroup,
  pattern = 'cpp',
  desc = 'Auto-generate compile_flags.txt for AtCoder projects',
  callback = function()
    -- 現在のパスがatcoderプロジェクト内か確認
    local current_path = vim.fn.getcwd()
    local atcoder_root = vim.fn.expand('~/atcoder')

    if string.find(current_path, atcoder_root, 1, true) then
      -- compile_flags.txtのパスを定義
      local flags_file = atcoder_root .. '/compile_flags.txt'
      -- 記述する内容を定義 (ホームディレクトリを動的に展開し、絶対パスを生成)
      local flags_content = '-std=c++20\n-I' .. atcoder_root
      -- ファイルに書き込み (vim.splitで改行をテーブルに変換)
      vim.fn.writefile(vim.split(flags_content, '\n'), flags_file)
    end
  end,
})
