return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'tokyonight-moon',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        {
          'filename',
          -- 0: ファイル名のみ
          -- 1: 相対パス (プロジェクトルートからの経路)
          -- 2: 絶対パス (フルパス)
          -- 3: 絶対パス (~/から始まる省略形)
          -- 4: ファイル名と親ディレクトリのみを表示
          path = 1,
          file_status = true,
        },
      },
    },
  },
}
