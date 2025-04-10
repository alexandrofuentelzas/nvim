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

-- Custom action to open selected item in current buffer or new tab
local open_file = function(prompt_bufnr)
    local selection = action_state.get_selected_entry(prompt_bufnr)
    actions.close(prompt_bufnr)

    local file_path
    if selection.path then
        file_path = selection.path
    elseif selection.filename then
        file_path = selection.filename
    elseif selection.value then
        file_path = selection.value
    end

    -- Check if current buffer is empty and unnamed
    local current_buf = vim.api.nvim_get_current_buf()
    local current_buf_name = vim.api.nvim_buf_get_name(current_buf)
    local is_empty = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)[1] == ""

    if current_buf_name == "" and is_empty then
        -- If current buffer is empty and unnamed, use it
        vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
    else
        -- Otherwise, check for existing tab or create new one
        if not switch_to_existing_tab(file_path) then
            vim.cmd('tabnew ' .. vim.fn.fnameescape(file_path))
        end
    end

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
        ["<CR>"] = open_file
      },
      n = {
        ["<CR>"] = open_file
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
