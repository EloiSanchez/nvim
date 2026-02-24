-- Improves treesitter for neovim. Also provides functions to install
-- parsers with ease. See :TSInstall
--
-- https://github.com/nvim-treesitter/nvim-treesitter
local ensure_installed_packages = {
  "lua",
  "python",
  "sql",
  "vim",
  "vimdoc",
  "query",
  "luadoc",
  "sql",
  "markdown",
  "json",
  "yaml",
}
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local nvim_ts = require("nvim-treesitter")
      nvim_ts.setup()
      nvim_ts.install(ensure_installed_packages)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = ensure_installed_packages,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },

  -- This extension for treesitter allows current config to stick on top of the window
  -- when scrolling down
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
}
