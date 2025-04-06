vim.g.mapleader = " "

local function map(modes, lhs, rhs, opts)
  opts = opts or {}
  if type(modes) == "string" then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Remap hjkl to jkl; for normal and visual modes
map({ "n", "v" }, "j", "h", { silent = true })
map({ "n", "v" }, "k", "k", { silent = true })
map({ "n", "v" }, ";", "j", { silent = true })

map({"n"},"<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
