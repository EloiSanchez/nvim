-- LSP configurations provided by nvim-lspconfig
-- What happens in the config function is vanilla nvim, which by default takes
-- the data from the configs provided by nvim-lspconfig
--
-- https://github.com/neovim/nvim-lspconfig
-- :h vim.lsp
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },

    config = function()
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")

      -- TODO: If this is tested and works well in production, commit it to
      -- nvim-lspconfig
      -- TODO: Make default language ansi unless .sqlfluff is found
      vim.lsp.config("sqlfluff-lsp", {
        cmd = { "sqlfluff-lsp", "serve" },
        filetypes = { "sql" },
        root_markers = { ".sqlfluff" },
      })
      vim.lsp.enable("sqlfluff-lsp")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client then
            -- Disable weird semantic highlighting when entering a python buffer
            -- then we rely only on treesitter, which has to be reactivated for this
            -- buffer
            if client.name == "basedpyright" then
              client.server_capabilities.semanticTokensProvider = nil
              vim.treesitter.start()
            end
          end
        end,
      })
    end,
  },
}
