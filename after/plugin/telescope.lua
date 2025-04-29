local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

-- Function to switch to a tab containing a specific buffer
local function switch_to_existing_tab(file_path)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_name(buf) == file_path then
            vim.api.nvim_set_current_win(win)
            return true
        end
    end
    return false
end

-- Custom action to open selected item
local function open_file(prompt_bufnr, method)
    local selection = action_state.get_selected_entry(prompt_bufnr)
    actions.close(prompt_bufnr)

    if not selection then
        print("No selection made")
        return
    end

    local file_path
    if selection.path then
        file_path = selection.path
    elseif selection.filename then
        file_path = selection.filename
    elseif selection.value then
        file_path = selection.value
    end

    if not file_path then
        print("No file path found")
        return
    end

    -- Check if current buffer is empty and unnamed
    local current_buf = vim.api.nvim_get_current_buf()
    local current_buf_name = vim.api.nvim_buf_get_name(current_buf)
    local buf_lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
    local is_empty = (#buf_lines == 1 and buf_lines[1] == "") or (#buf_lines == 0)

    -- Decide how to open
    if method == "edit" then
        if current_buf_name == "" and is_empty then
            -- If current buffer is empty and unnamed, reuse it
            vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
        else
            vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
        end
    elseif method == "split" then
        vim.cmd('split ' .. vim.fn.fnameescape(file_path))
    elseif method == "vsplit" then
        vim.cmd('vsplit ' .. vim.fn.fnameescape(file_path))
    elseif method == "tabnew" then
        if not switch_to_existing_tab(file_path) then
            vim.cmd('tabnew ' .. vim.fn.fnameescape(file_path))
        end
    end

    -- Move to line/column if available
    if selection.lnum then
        vim.cmd('normal! ' .. selection.lnum .. 'G')
        if selection.col then
            vim.cmd('normal! ' .. selection.col .. '|')
        end
    end
end

-- Setup Telescope with custom mappings
local telescope = require('telescope')
telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<CR>"] = function(prompt_bufnr) open_file(prompt_bufnr, "edit") end,
        ["<C-s>"] = function(prompt_bufnr) open_file(prompt_bufnr, "split") end,
        ["<C-v>"] = function(prompt_bufnr) open_file(prompt_bufnr, "vsplit") end,
        ["<C-t>"] = function(prompt_bufnr) open_file(prompt_bufnr, "tabnew") end,
      },
      n = {
        ["<CR>"] = function(prompt_bufnr) open_file(prompt_bufnr, "edit") end,
        ["<C-s>"] = function(prompt_bufnr) open_file(prompt_bufnr, "split") end,
        ["<C-v>"] = function(prompt_bufnr) open_file(prompt_bufnr, "vsplit") end,
        ["<C-t>"] = function(prompt_bufnr) open_file(prompt_bufnr, "tabnew") end,
      }
    }
  }
}

-- Key mappings
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Search for word ") })
end)

