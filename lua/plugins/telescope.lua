-- Pickers for finding stuff
-- https://github.com/nvim-telescope/telescope.nvim
return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',

      -- Optional extensions
      'nvim-tree/nvim-web-devicons',                                  -- Icons
      'BurntSushi/ripgrep',                                           -- For using telescope grep commands
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- Native sorter
    },

    -- Make telescope slightly wider by default
    config = function()
      require('telescope').setup {
        defaults = {
          layout_config = {
            horizontal = { width = 0.9 },
          },
        },
      }
    end,
  },
}
