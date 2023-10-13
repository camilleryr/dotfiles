return {
  {
    'tpope/vim-fugitive',
    config = function()
      local set = vim.keymap.set
      -- fugitive bindings
      set('n', '<leader>gs', ':Git<cr>', {})
      set('n', '<leader>gS', ':Telescope git_stash<cr>', {})
      set('n', '<leader>gc', ':Telescope git_bcommits<cr>', {})
      set('n', '<leader>gC', ':Telescope git_commits<cr>', {})
      set('n', '<leader>gb', ':Telescope git_branches<cr>', {})
    end
  },
  'tpope/vim-rhubarb',
  'tpope/vim-fireplace',
  'tpope/vim-dispatch',
  'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired',
  'tpope/vim-surround',
  'tpope/vim-abolish',
  'tpope/vim-scriptease',
  'tpope/vim-speeddating',
  'tpope/vim-endwise',
  'tpope/vim-vinegar',
  'tpope/vim-rsi',
  'tpope/vim-dadbod'
}
