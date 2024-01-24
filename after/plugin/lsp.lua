local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gI', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = "[g]et [I]nformation under cursor", unpack(opts)})
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "[g]o to [d]efinition", unpack(opts)})
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = "[g]o to [D]eclaration", unpack(opts)})
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = "[g]o to [i]mplementation", unpack(opts)})
  vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = "[g]o to [t]ype definition", unpack(opts)})
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = "[g]et the [r]eferences", unpack(opts)})
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = "[g]et help with the [s]ignature", unpack(opts)})
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = "Rename variable [<F2>]", unpack(opts)})
  vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { desc = "Format file [<F3>]", unpack(opts)})
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = "Code action [<F4>]", unpack(opts)})

  vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = "Open Floating Window [gl]", unpack(opts)})
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = "Go To Prev [d", unpack(opts)})
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = "Go To Next ]d", unpack(opts)})
end)

require('mason').setup({})

require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts) end,
  }
})

local cmp = require 'cmp'

-- luasnip setup
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-u>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.select_prev_item(),
    ['<C-p>'] = cmp.mapping.scroll_docs(-4),
    ['<C-n>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

