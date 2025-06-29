return {
  {
    "neovim/nvim-lspconfig",
    version = "*",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
      "artemave/workspace-diagnostics.nvim",
    },

    config = function()
      local cmp = require("cmp")
      local cmp_lsp = require("cmp_nvim_lsp")
      local cababilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

      require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "lua_ls",
          "rust_analyzer",
          "angularls",
          "cssls",
          "tailwindcss",
          "gopls",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = cababilities,
            })
          end,
          ["ts_ls"] = function()
            require("lspconfig")["ts_ls"].setup({
              capabilities = cababilities,
              on_attach = function(client, bufnr)
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
              end,
            })
          end,
          ["tailwindcss"] = function()
            require("lspconfig")["tailwindcss"].setup({
              settings = {
                tailwindCSS = {
                  experimental = {
                    classRegex = {
                      "tw`([^`]*)",
                      "tw=\"([^\"]*)",
                      "tw={\"([^\"}]*)",
                      "tw\\.\\w+`([^`]*)",
                      "tw\\(.*?\\)`([^`]*)",
                      "tw.style\\(([^)]*)\\)",
                    }
                  }
                }
              }
            })
          end,
          ["lua_ls"] = function()
            require('lspconfig')['lua_ls'].setup({
              capabilities = cababilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' },
                  },
                },
              },
            })
          end,
          ["gopls"] = function()
            require('lspconfig')['gopls'].setup({
              capabilities = cababilities,
              settings = {
                gopls = {
                  analyses = {
                    unusedparams = true,
                  },
                  staticcheck = true,
                },
              },
            })
          end,
        },
      })


      --local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

      local cmp_select = {behavior = cmp.SelectBehavior.Select}

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-space>'] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
            { name = 'buffer' },
          })
      })

      -- Setup up vim-dadbod
      cmp.setup.filetype({ "sql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })

      vim.diagnostic.config({
        update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        }
      })
    end
  }
}

