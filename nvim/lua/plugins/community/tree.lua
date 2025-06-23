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
    require('neo-tree').setup({
      close_if_last_window = true,
      sources = {
        'filesystem',
        'buffers',
        'git_status',
      },
      window = {
        position = 'left',
        width = 30,
        mappings = {
          ['b'] = function(_)
            require('neo-tree.command').execute({ source = 'buffers', toggle = true })
          end,
          ['g'] = function(_)
            require('neo-tree.command').execute({ source = 'git_status', toggle = true })
          end,
          ['f'] = function(_)
            require('neo-tree.command').execute({ source = 'filesystem', toggle = true })
          end,
        },
      },
      -- Gitのステータス（変更、無視ファイルなど）を表示する機能を有効化
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    })
  end,
}
