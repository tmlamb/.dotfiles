local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.g.neoformat_try_node_exe = 1
-- ,'TextChanged','InsertLeave'
autocmd({'BufWritePre'}, {
  pattern = {'*.js', '*.ts', '*.jsx', '*.tsx', '*.css', '*.scss', '*.html', '*.json', '*.yaml', '*.yml', '*.md'},
  command = ':Neoformat'
})
