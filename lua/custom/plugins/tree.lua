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
    vim.keymap.set('n', '<leader>nt', ':NvimTreeFindFileToggle<CR>', { desc = '[N]vim-tree [T]oggle' })
    vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>', { desc = '[N]vim-tree [F]ind File' })
  end,
}
