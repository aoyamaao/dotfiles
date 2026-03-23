local utils_dir = vim.fn.stdpath('config') .. '/lua/utils'

for _, file in ipairs(vim.fn.readdir(utils_dir)) do
  if file:match('%.lua$') and file ~= 'init.lua' then
    local module_name = file:gsub('%.lua$', '')
    require('utils.' .. module_name)
  end
end
