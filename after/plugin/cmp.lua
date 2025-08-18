local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = function(fallback)
        fallback()
    end,
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Set up lspconfig with nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Use this updated capabilities when setting up your LSP servers

-- Make cmp popup background a little gray
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#2e2e2e" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#FFFF00" })
