return {
  'phaazon/hop.nvim',
  branch = 'v2',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>s',
      function()
        require('hop').hint_char1()
      end,
      mode = 'n',
      desc = 'Hop to 1 character',
    },
    {
      '<leader>S',
      function()
        require('hop').hint_words()
      end,
      mode = 'n',
      desc = 'Hop to word',
    },
  },
  config = function()
    require('hop').setup()
  end,
}
