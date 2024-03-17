return {
  {
    "tpope/vim-fugitive",
    name = "fugitive",
    config = function()
      vim.keymap.set('n', "<leader>gs", vim.cmd.Git);
    end,
  },
  { "tpope/vim-rhubarb", dependencies = { "fugitive" }},
}
