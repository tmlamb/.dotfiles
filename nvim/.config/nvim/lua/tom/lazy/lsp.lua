return {
  {
    "williamboman/mason.nvim",
    dependencies = {
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

      -- Build capabilities once and apply to ALL servers via the '*' wildcard config
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )
      vim.lsp.config('*', { capabilities = capabilities })

      -- Enable all servers (configs come from nvim/lsp/<name>.lua files)
      vim.lsp.enable({
        'ts_ls',
        'eslint',
        'lua_ls',
        'rust_analyzer',
        'cssls',
        'tailwindcss',
        'gopls',
      })

      -- Populate workspace-wide diagnostics when ts_ls attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == 'ts_ls' then
            require("workspace-diagnostics").populate_workspace_diagnostics(client, args.buf)
          end
        end,
      })

      require("fidget").setup({})
      require("mason").setup()

      -- Prompt mason to install servers that aren't already present.
      -- mason-lspconfig is no longer used; this list is just for reference.
      -- Run :MasonInstall <name> or :Mason to manage servers manually.

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

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

      -- vim-dadbod completion for SQL files
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
