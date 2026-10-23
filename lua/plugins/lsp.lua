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
      vim.lsp.enable("ruff")

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" } }
          }
        }
      })

      vim.lsp.config("sqlmesh-lsp", {
        cmd = { "sqlmesh_lsp", },
        filetypes = { "sql" },
        root_markers = { "config.yaml" },
      })
      vim.lsp.enable("sqlmesh-lsp")
    end,
  },
}
