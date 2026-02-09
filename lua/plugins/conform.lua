-- Conform is used to format:
-- :lua require('conform').format(...)  <-- will format current buffer
--
-- The format_on_save keyword is a shortcut that avoids having to create
-- an autocmd
-- https://github.com/stevearc/conform.nvim
return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          sql = { "sqlfluff-lsp" },
          markdown = { "prettier" },
          yaml = { "prettier" },
          json = { "prettier" },
          ["_"] = { "trim_whitespaces" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters = {
          stylua = { append_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
        },
      })
    end,
  },
}
