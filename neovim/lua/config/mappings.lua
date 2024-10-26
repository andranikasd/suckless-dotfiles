local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Exit inster mode 
map("i", "jk", "<ESC>")


