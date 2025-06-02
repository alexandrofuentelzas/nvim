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
map({ "n", "v" }, ";", "j", { silent = true })

-- Remap Ctrl-hjkl to Ctrl-jkl; for normal and visual modes
map({ "n", "v" }, "<C-w>j", "<C-w>h", { silent = true })
map({ "n", "v" }, "<C-w>;", "<C-w>j", { silent = true })

-- Toggle NvimTree
map({"n"},"<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

map({"n"}, "n", "nzzzv", { silent = true} )
map({"n"}, "N", "Nzzzv", { silent = true} )

map({"n"}, "<leader>rw", function()
 vim.ui.input({ prompt = "Word to replace: " }, function(find)
    if find then
      vim.ui.input({ prompt = "Replace with: " }, function(replace)
        if replace then
          -- Escape forward slashes to prevent errors
          find = find:gsub("/", "\\/")
          replace = replace:gsub("/", "\\/")
          vim.cmd(":%s/" .. find .. "/" .. replace .. "/gc")
        end
      end)
    end
  end)
end, { desc = "Find and replace with confirmation", noremap = true, silent = true })

map({"n"}, "<leader>jq", function()
    vim.cmd("%!jq '.'")
end, {silent = true, desc = "Basic JSON Formatting"})

-- Modifying p command to dump highlighed text to be replaced in the black hole register 
map('x', 'p', '"_dP', { noremap = true, silent = true })

