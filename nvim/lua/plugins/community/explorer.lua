return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = 'Toggle Neo-tree',
    },
  },

  config = function()
    -- ソースを切り替えるコマンドを生成する (b/g/fで共通の形に揃える)
    local function toggle_source(source)
      return function()
        require('neo-tree.command').execute({ source = source, toggle = true })
      end
    end

    -- ノードのパスを形式を選んでクリップボードへコピーする
    local function copy_path(state)
      local path = state.tree:get_node():get_id()
      local modify = vim.fn.fnamemodify
      local choices = {
        { label = '絶対パス       ', value = path },
        { label = '相対パス(CWD)  ', value = modify(path, ':.') },
        { label = '相対パス(HOME) ', value = modify(path, ':~') },
        { label = 'ファイル名     ', value = modify(path, ':t') },
      }
      vim.ui.select(choices, {
        prompt = 'コピーする形式:',
        format_item = function(item)
          return item.label .. '  ' .. item.value
        end,
      }, function(choice)
        if choice then
          vim.fn.setreg('+', choice.value)
          vim.notify('Copied: ' .. choice.value)
        end
      end)
    end

    require('neo-tree').setup({
      close_if_last_window = true,
      sources = {
        'filesystem',
        'buffers',
        'git_status',
      },
      window = {
        position = 'left',
        width = 50,
        mappings = {
          -- ソース切り替え
          ['b'] = toggle_source('buffers'),
          ['g'] = toggle_source('git_status'),
          ['f'] = toggle_source('filesystem'),
          -- コピー・移動(行き先を相対パスで表示)
          ['c'] = { 'copy', config = { show_path = 'relative' } },
          ['m'] = { 'move', config = { show_path = 'relative' } },
          -- パスをクリップボードへ(形式を選択)
          ['Y'] = copy_path,
        },
      },
      -- Gitのステータス(変更、無視ファイルなど)を表示する機能を有効化
      filesystem = {
        -- 現在開いているファイルに自動追従する
        follow_current_file = {
          enabled = true, -- 追従を有効化
          leave_dirs_open = false, -- 別フォルダのファイルを開いたときに以前のフォルダを自動で閉じる
        },
        -- 裏側のファイル変更を即座にツリーに反映させる
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    })
  end,
}
