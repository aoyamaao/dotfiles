-- Markdownバッファの設定

-- 保存時にfrontmatterのupdatedDateを更新
local function update_frontmatter_date()
  local lines = vim.api.nvim_buf_get_lines(0, 0, 20, false)
  if lines[1] ~= '---' then
    return
  end
  local closing_idx, target_idx
  for i = 2, #lines do
    if lines[i] == '---' then
      closing_idx = i
      break
    elseif lines[i]:match('^updatedDate:') then
      target_idx = i
    end
  end
  if closing_idx and target_idx and target_idx < closing_idx then
    local date_str = os.date('%Y-%m-%dT%H:%M:%S+09:00')
    vim.api.nvim_buf_set_lines(
      0,
      target_idx - 1,
      target_idx,
      false,
      { 'updatedDate: ' .. date_str }
    )
    vim.notify('updatedDateを更新しました。', vim.log.levels.INFO)
  end
end

vim.api.nvim_create_autocmd('BufWritePre', {
  buffer = 0, -- このバッファだけに紐づける
  callback = update_frontmatter_date,
})

-- 目次をlocation listに表示
vim.keymap.set(
  'n',
  '<leader>fl',
  '<cmd>lvimgrep /^#/ %<cr><cmd>lopen<cr>',
  { buffer = true, desc = 'TOC to Location list' }
)
