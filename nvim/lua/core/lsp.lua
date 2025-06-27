local M = {}

-- LSPサーバーがアタッチされた際の共通設定
M.on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('gl', vim.diagnostic.open_float, 'Line Diagnostics')
  nmap('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
  nmap(']d', vim.diagnostic.goto_next, 'Next Diagnostic')

  -- カーソルホバーで診断メッセージを自動表示する
  local diagnostic_augroup = vim.api.nvim_create_augroup('lsp_diagnostics_hover', { clear = true })
  vim.api.nvim_create_autocmd({ 'CursorHold' }, {
    group = diagnostic_augroup,
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, {
        scope = 'cursor',
        focusable = false,
      })
    end,
  })
end

-- nvim-cmpにLSPの補完能力を伝えるためのcapabilitiesもここで定義
M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
