return {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, {
      '.clangd',
      'compile_commands.json',
      'compile_flags.txt',
      '.git',
    })

    local filename = vim.api.nvim_buf_get_name(bufnr)
    on_dir(root or vim.fs.dirname(filename) or vim.fn.getcwd())
  end,
}
