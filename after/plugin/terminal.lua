local Terminal = require('toggleterm.terminal').Terminal

-- Horizontal terminal
local horizontal_term = Terminal:new({
    direction = "horizontal",
    size = 15,
})

-- Floating terminal
local float_term = Terminal:new({
    direction = "float",
    float_opts = {
        border = 'curved',
    }
})

-- Functions to toggle each terminal
function _horizontal_term_toggle()
    horizontal_term:toggle()
end

function _vertical_term_toggle()
    vertical_term:toggle()
end

function _float_term_toggle()
    float_term:toggle()
end

-- Key mappings
vim.keymap.set('n', '<leader>th', '<cmd>lua _horizontal_term_toggle()<CR>')
vim.keymap.set('n', '<leader>tv', '<cmd>:vsplit | terminal<CR>')
vim.keymap.set('n', '<leader>tf', '<cmd>lua _float_term_toggle()<CR>')
