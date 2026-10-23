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
          python = { "ruff" },
          sql = { lsp_format = "prefer", timeout_ms = 3000 },
          markdown = { "prettier" },
          yaml = { "prettier" },
          json = { "prettier" },
          -- ["_"] = { "trim_whitespaces" },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end,

        -- Configuration for specific formatters
        formatters = {
          stylua = { append_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
        },
      })

      -- User command to disable format on save
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      -- User command to enable format on save
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}
