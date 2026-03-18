return {
  {
    "sbdchd/neoformat" ,

    config = function()
      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      vim.g.neoformat_try_node_exe = 1
      vim.g.neoformat_only_msg_on_error = 1

      -- Override prettier to run from the file's directory so that plugins
      -- referenced in package.json (e.g. @ianvs/prettier-plugin-sort-imports)
      -- can be resolved correctly in monorepos where Neovim's cwd may not be
      -- the project root.
      local prettier_fmt = {
        exe = 'prettier',
        args = { '--stdin-filepath', '"%:p"' },
        stdin = 1,
        try_node_exe = 1,
        cwd = 'expand("%:p:h")',
      }
      vim.g.neoformat_typescript_prettier = prettier_fmt
      vim.g.neoformat_typescriptreact_prettier = prettier_fmt
      vim.g.neoformat_javascript_prettier = prettier_fmt
      vim.g.neoformat_javascriptreact_prettier = prettier_fmt
      vim.g.neoformat_css_prettier = prettier_fmt
      vim.g.neoformat_scss_prettier = prettier_fmt
      vim.g.neoformat_html_prettier = prettier_fmt
      vim.g.neoformat_json_prettier = prettier_fmt
      vim.g.neoformat_yaml_prettier = prettier_fmt
      vim.g.neoformat_markdown_prettier = prettier_fmt

      -- ,'TextChanged','InsertLeave'
      autocmd({'BufWritePre'}, {
        pattern = {'*.cjs', '*.mjs', '*.js', '*.ts', '*.jsx', '*.tsx', '*.css', '*.scss', '*.html', '*.json', '*.yaml', '*.yml', '*.md', '*.go'},
        command = ':Neoformat'
      })
    end
  },
}
