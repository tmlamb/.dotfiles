vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste from system clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Credit: asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("i", "jj", "<Esc>")
-- vim.keymap.set('i', '<Esc>', '<Nop>', { noremap = true, silent = true })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Insert mode: <C-u> inserts a trimmed uuid
-- vim.keymap.set(
--   "i",
--   "diuu",
--   function()
--     return vim.fn.trim(vim.fn.system("uuidgen"))
--   end,
--   { expr = true }
-- )

-- Normal mode: <C-u> enters insert, inserts a trimmed uuid, then exits insert
vim.keymap.set(
  "n",
  "<leader>diuu",
  function()
    return "i"
      .. vim.fn.trim(vim.fn.system("uuidgen"))
      .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  end,
  { expr = true }
)

