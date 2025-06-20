-- plugins.lua

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

  -- Code Formatter
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- python = { "black" },
        -- cpp = { "clang-format" },
      },
    },
  },

  -- ColorScheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "tokyonight-moon"
    end,
  },

  -- StatusLine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "tokyonight-moon",
        },
      }
    end,
  },

  -- UndoTree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
    },
  },

  -- Git
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    keys = {
      { "<leader>g", group = "Git" },
      -- Git Status
      { "<leader>gs", "<cmd>G<cr>", desc = "Status" },
      -- Git Add
      { "<leader>ga", "<cmd>G add .<cr>", desc = "Add all" },
      { "<leader>gp", "<cmd>G add %<cr>", desc = "Add current file" },
      -- Git Commit
      { "<leader>gc", "<cmd>G commit<cr>", desc = "Commit" },
      { "<leader>gca", "<cmd>G commit -a<cr>", desc = "Commit all" },
      -- Git Diff
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Diff" },
      { "<leader>gds", "<cmd>Gdiffsplit --staged<cr>", desc = "Diff Staged" },
      -- Git Log
      { "<leader>gl", "<cmd>G log<cr>", desc = "Log" },
      { "<leader>gL", "<cmd>G log --graph --oneline --decorate --all<cr>", desc = "Log (Graph)" },
      -- Git Push
      { "<leader>gp", group = "Push" },
      { "<leader>gpp", "<cmd>G push<cr>", desc = "Push" },
      { "<leader>gpf", "<cmd>G push --force-with-lease<cr>", desc = "Push (Force with lease)" },
    },
  },

  -- Key mapping list
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      --require("which-key").setup({})
    end,
  },
}

require("lazy").setup(plugins, {})
