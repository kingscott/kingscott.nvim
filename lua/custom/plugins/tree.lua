-- nvim-tree and config
return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}

    -- TODO these keymaps don't really make sense
    vim.keymap.set('n', '<leader>f', ':NvimTreeFindFileToggle<CR>', { desc = 'Toggle [F]ile tree' })
    vim.keymap.set('n', '<leader>ff', ':NvimTreeFindFile<CR>', { desc = '[F]ind [F]file in tree' })
  end,
}
