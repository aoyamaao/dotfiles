return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('tokyonight-moon')
    vim.api.nvim_set_hl(
      0,
      'MatchParen',
      { bg = '#444444', fg = '#ff966c', bold = true, underline = true }
    )
    vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#000032' })
  end,
}
