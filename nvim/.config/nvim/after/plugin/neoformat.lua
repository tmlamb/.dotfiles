local autocmd = vim.api.nvim_create_autocmd

vim.g.neoformat_try_node_exe = 1

autocmd({'BufWritePre','TextChanged','InsertLeave'}, {
  pattern = {'*.js', '*.ts', '*.jsx', '*.tsx', '*.css', '*.scss', '*.html', '*.json', '*.yaml', '*.yml', '*.md'},
  command = ':Neoformat'
})
