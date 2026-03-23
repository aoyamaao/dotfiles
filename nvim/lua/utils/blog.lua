local function get_date()
  return os.date('%Y-%m-%dT%H:%M:%S+09:00')
end

local function update_frontmatter_date()
  if vim.bo.filetype ~= 'markdown' then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, 20, false)
  if lines[1] ~= '---' then
    return
  end

  local closing_idx = nil
  local target_idx = nil

  for i = 2, #lines do
    if lines[i] == '---' then
      closing_idx = i
      break
    elseif lines[i]:match('^updatedDate:') then
      target_idx = i
    end
  end

  if closing_idx and target_idx and target_idx < closing_idx then
    local date_str = get_date()
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

local blog_augroup = vim.api.nvim_create_augroup('BlogAutoUpdate', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = blog_augroup,
  pattern = '*.md',
  callback = update_frontmatter_date,
})

local function insert_frontmatter()
  local date_str = get_date()
  local template = {
    '---',
    'title: ""',
    'meta_title: ""',
    'description: ""',
    'publishDate: ' .. date_str,
    'updatedDate: ' .. date_str,
    'draft: true',
    'categories:',
    '  - ""',
    'tags:',
    '  - ""',
    '---',
    '',
  }

  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, template)
  vim.api.nvim_win_set_cursor(0, { row + 1, 9 })
end

vim.keymap.set('n', '<Leader>mi', insert_frontmatter, { desc = 'フロントマターを挿入' })
