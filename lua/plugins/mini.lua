-- Many small QOL modules from a single repo
-- https://github.com/nvim-mini/mini.nvim
return {
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      -- status line: https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-statusline.md
      require('mini.statusline').setup()

      -- notifications: https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-notify.md
      local function win_config()
        local has_statusline = vim.o.laststatus > 0 -- Is there status line?
        local v_pad = vim.o.cmdheight + (has_statusline and 1 or 0) + 1
        local h_pad = 1
        return { anchor = 'SE', col = vim.o.columns - h_pad, row = vim.o.lines - v_pad }
      end
      require('mini.notify').setup { window = { config = win_config } }

      -- highlight cursor word: https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-cursorword.md
      -- TODO: Remove cursorword if buffer is not modifiable
      require('mini.cursorword').setup()

      -- autopairs: https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-pairs.md
      require('mini.pairs').setup()

      -- surround: https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-surround.md
      require('mini.surround').setup()
    end,
  },
}
