return {
  {
    "github/copilot.vim",
    init = function()
      local disabled_dirs = {
        "~/workspaces/learn",
      }

      local cwd = vim.loop.fs_realpath(vim.fn.getcwd()) or vim.fn.getcwd()

      for _, dir in ipairs(disabled_dirs) do
        dir = vim.loop.fs_realpath(vim.fn.expand(dir)) or vim.fn.expand(dir)

        if cwd == dir or vim.startswith(cwd, dir .. "/") then
          vim.g.copilot_enabled = false
          break
        end
      end
    end,
  }
}
