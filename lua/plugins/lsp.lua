return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } }
  },

  { 'VonHeikemen/lsp-zero.nvim' },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },

  { 'windwp/nvim-autopairs' },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
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
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jay-babu/mason-nvim-dap.nvim' },
      { 'VonHeikemen/lsp-zero.nvim' },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config
      local lsp_zero = require('lsp-zero')

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          local builtin = require("telescope.builtin")

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
            { desc = "Format", buffer = event.buf })

          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>',
            { desc = "Code Action", buffer = event.buf })

          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", buffer = event.buf })
          vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "[G]o to [R]eferences", buffer = event.buf })
          vim.keymap.set('n', 'gi', builtin.lsp_implementations,
            { desc = "[G]o to [I]mplementations", buffer = event.buf })
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = "Rename", buffer = event.buf })
          vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = "[G]o to Type Definition", buffer = event.buf })
          vim.keymap.set('n', 'gS', vim.lsp.buf.signature_help, { desc = "[G]et [S]ignature help", buffer = event.buf })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = { '[G]o to [D]eclaration' }, buffer = event.buf })
        end,
      })

      require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls", "jdtls" },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })

      require('mason-nvim-dap').setup({
        ensure_installed = { "java-debug-adapter", "java-test" }
      })
    end
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "mfussenegger/nvim-dap",
    }
  },
}
