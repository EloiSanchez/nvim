-- All the custom keymaps are defined here for centrality

-- Helper reference to vim keymap set function
local map = vim.keymap.set

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows (See :help wincmd)
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[ Telescope ]]
local builtin = require 'telescope.builtin'
map('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Find via Grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
map('n', '<leader><leader>', builtin.buffers, { desc = 'Find Buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help tags' })
map('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })
map('n', '<leader>fr', builtin.resume, { desc = 'Find Resume previous' })
map('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Find in Current buffer' })
map('n', 'grr', builtin.lsp_references, { desc = 'Go to References' })
map('n', 'grd', builtin.lsp_definitions, { desc = 'Go to Reference Definitions' })
map('n', 'gtd', builtin.lsp_type_definitions, { desc = 'Go to Type Definitions' })

-- [[ Conform ]]
local conform = require 'conform'
map('n', '<leader>fm', function()
  conform.format()
end, { desc = 'ForMat current buffer' })

-- [[ Gitsigns ]]
-- Hunks
map('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { desc = 'Hunk Preview' })
map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = 'Hunk Reset' })
map('n', '<leader>hn', ':Gitsigns nav_hunk next<CR>', { desc = 'Hunk Next' })
map('n', '<leader>hN', ':Gitsigns nav_hunk prev<CR>', { desc = 'Hunk Previous' })

-- Git
map('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = 'Git Blame' })

-- Toggles
map('n', '<leader>tb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle Blame' })
map('n', '<leader>td', ':Gitsigns toggle_word_diff<CR>', { desc = 'Toggle Word Diff' })

-- [[ Neotree ]]
map('n', '\\', ':Neotree toggle<CR>', { desc = 'Neotree toggle' })

-- [[ Diffview ]]
map('n', '<leader>cm', ':DiffviewOpen main<CR>', { desc = 'Compare with main' })
map('n', '<leader>cc', ':DiffviewOpen<CR>', { desc = 'Compare with current status' })
map('n', '<leader>cx', ':DiffviewClose<CR>', { desc = 'Close diffview' })

-- [[ Diagnostics ]]
map('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open Diagnostic Floating message' })
local diagnostic = vim.diagnostic
map('n', '<leader>dn', function()
  diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic' })
map('n', '<leader>dN', function()
  diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to next diagnostic' })
map('n', '<leader>dv', function()
  vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
end, { desc = 'Toggle virtual text for diagnostics' })
map('n', '<leader>dq', function()
  local diagnostics = diagnostic.get(vim.api.nvim_get_current_buf())
  if #diagnostics > 0 then
    vim.fn.setqflist(diagnostic.toqflist(diagnostics))
    vim.cmd 'copen'
  else
    vim.notify 'No diagnostics in current buffer'
  end
end, { desc = 'Open diagnostics in quickfix list' })
map('n', '<leader>dt', function()
  local prefixes = { ' ERRORS', ' WARNINGS', ' INFO', ' HINTS' }
  local message = ''
  local default_message = 'All good!'
  local max_level = 2
  for level, value in pairs(diagnostic.count(0)) do
    local parsed_level = 5 - level
    if parsed_level > max_level then
      max_level = parsed_level
    end
    message = message .. '\n' .. tostring(value) .. prefixes[level]
  end
  if message == '' then
    message = default_message
  end
  vim.notify(message, max_level)
end, { desc = 'Show count of total diagnostics' })
