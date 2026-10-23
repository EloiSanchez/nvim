return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      interactions = {
        chat = {
          adapter = "surf_gateway"
        },
        inline = {
          adapter = "surf_gateway"
        }
      },
      adapters = {
        http = {
          surf_gateway = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "Surf Gateway",
              env = {
                url = "https://api.willma.surf.nl",
                api_key = "SURF_API_KEY",
                chat_url = "/v0/chat/completions",
                models_endpoint = "/v0/models"
              },
              schema = {
                model = {
                  default = "openai/gpt-oss-120b",
                },
              },
            })
          end,
        },
      },
    })
  end
}
