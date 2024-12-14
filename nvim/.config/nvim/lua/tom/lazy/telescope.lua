return {
  "nvim-telescope/telescope.nvim",

  depedencies = {
    "plenary"
  },

  name = "telescope",

  config = function()
    require('telescope').setup({  defaults = { file_ignore_patterns = { "node_modules", }} })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>pws',  function()
      builtin.grep_string();
    end)
    vim.keymap.set('n', '<leader>pWs',  function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word });
    end)
    vim.keymap.set('n', '<leader>ps',  function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}
