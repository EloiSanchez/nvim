-- Helps with git repos with
-- - Showing hunks of changes
-- - Navigating hunks
-- - Blame
-- - Diff of hunks
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signcolumn = false,
      numhl = true,
    },
  },
}
