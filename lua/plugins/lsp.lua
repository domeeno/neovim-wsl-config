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
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" }
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help'
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      -- Lazy-load snippets for better performance
      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_lua').load({ paths = "~/.config/nvim/lua/snippets" })
        end,
      })

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
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
              cmp.complete()
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
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
        }),
      }

      -- Ensure LSP capabilities include snippet support
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("lspconfig").gopls.setup {
        capabilities = capabilities,
      }
    end
  }
  ,

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
        ensure_installed = { "clangd", "lua_ls", "jdtls" },
        handlers = {
          lsp_zero.default_setup,
          clangd = function()
            require('lspconfig').clangd.setup {}
          end,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })

      require('mason-nvim-dap').setup({
        ensure_installed = { "java-debug-adapter", "java-test", "cppdbg" }
      })
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",             -- UI for DAP
      "theHamsta/nvim-dap-virtual-text",  -- Inline debugging text
      "mfussenegger/nvim-dap-python",     -- Python debugging support
      "nvim-telescope/telescope-dap.nvim" -- Telescope integration
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", "./", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false
        }
      }

      -- DAP UI Setup
      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- Auto open/close UI on debug start/stop
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Keybindings for DAP
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open Debug Console" })
      vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle Debug UI" })
    end
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "mfussenegger/nvim-dap",
    }
  },
}
