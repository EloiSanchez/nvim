-- Entry point for neovim configuration


-- [[ The following must be set before plugins are loaded ]]
-- Set map key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.timeout = false -- No timeout after pressing leader. To cancel press ESC

vim.g.have_nerd_font = true

-- [[ Settings ]]
-- Show relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Set default tabstyle
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.expandtab = true

-- Allow mouse for resizing and convenience
vim.o.mouse = "a"

-- Don't show current mode since it will be in status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Broken lines will continue on the same indentation as original
vim.o.breakindent = true

-- Save undo history to file (undo available after closing nvim)
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease time required for saving to swp and CursorHold events (default 4000)
vim.o.updatetime = 250

-- Decrease time to wait for a mapped out sequence to complete
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true -- right of current
vim.o.splitbelow = true -- below of current

-- Configure showing blank spaces
vim.o.list = true -- show TAB and EOL
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- use vim.opt instead of vim.o to have a better interface thanks to lua tables
-- see :help lua-options

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Remove wrap by default
vim.o.wrap = false

-- Set window border style
vim.o.winborder = "none"

-- Set floating diagnostics by default
vim.diagnostic.config({ virtual_text = true })

-- [[ Basic Autocommands ]]
-- :help lua-guide-autcommands
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Plugin configuration ]]
require("config.lazy")

-- [[ Set keymaps ]]
require("keymaps")
