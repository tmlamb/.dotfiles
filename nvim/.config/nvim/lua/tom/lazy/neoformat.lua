return {
  {
    "sbdchd/neoformat" ,

    config = function()
      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      vim.g.neoformat_try_node_exe = 1
      -- ,'TextChanged','InsertLeave'
      autocmd({'BufWritePre'}, {
        pattern = {'*.cjs', '*.mjs', '*.js', '*.ts', '*.jsx', '*.tsx', '*.css', '*.scss', '*.html', '*.json', '*.yaml', '*.yml', '*.md', '*.go'},
        command = ':Neoformat'
      })
    end
  },
}
