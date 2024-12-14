return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local detail = false
      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",

          ["<leader>oi"] = {
            desc = "Toggle file detail view",
            callback = function()
              detail = not detail
              if detail then
                require("oil").set_columns { "icon", "name", "size", "time" }
              else
                require("oil").set_columns { "icon" }
              end
            end,
          }
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory alt" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Open parent directory floating" })
    end,
  },
}
