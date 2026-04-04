local function get_date()
  return os.date('%Y-%m-%dT%H:%M:%S+09:00')
end

local function update_frontmatter_date()
  if vim.bo.filetype ~= 'markdown' and vim.bo.filetype ~= 'mdx' then
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
  pattern = { '*.md', '*.mdx' },
  callback = update_frontmatter_date,
})

local article_categories = {
  '  - コンピュータサイエンス',
  '  - プログラミング',
  '  - 開発環境',
  '  - 基礎教養',
}

local book_categories = {
  '  - 技術書',
  '  - 学術書',
  '  - 一般書',
}

local function insert_frontmatter(template_type)
  local date_str = get_date()
  local template = { '---' }

  if template_type == 'article' then
    vim.list_extend(template, {
      'title: ""',
      'description: ""',
      'publishDate: ' .. date_str,
      'updatedDate: ' .. date_str,
      'image: "/images/article/default.webp"',
      'draft: false',
      'categories:',
    })
    vim.list_extend(template, article_categories)
    vim.list_extend(template, {
      'tags:',
      '  - ""',
      '---',
      '',
    })
  elseif template_type == 'book' then
    vim.list_extend(template, {
      'title: ""',
      'subtitle: ""',
      'author: ""',
      'publisher: ""',
      'isbn: ""',
      'image: "/images/books/default.webp"',
      'publishDate: ' .. date_str,
      'updatedDate: ' .. date_str,
      'bookPublishedDate: ""',
      'draft: false',
      'categories:',
    })
    vim.list_extend(template, book_categories)
    vim.list_extend(template, {
      'tags:',
      '  - ""',
      '---',
      '',
    })
  end

  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, template)

  -- 挿入後、titleの "" の中にカーソルを自動で移動させる (row + 1行目の 8カラム目)
  vim.api.nvim_win_set_cursor(0, { row + 1, 8 })

  vim.cmd('startinsert')
end

vim.keymap.set('n', '<Leader>ma', function()
  insert_frontmatter('article')
end, { desc = '記事のフロントマターを挿入' })

vim.keymap.set('n', '<Leader>mb', function()
  insert_frontmatter('book')
end, { desc = '読書記録のフロントマターを挿入' })
