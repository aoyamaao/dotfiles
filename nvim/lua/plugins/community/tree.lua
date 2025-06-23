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
