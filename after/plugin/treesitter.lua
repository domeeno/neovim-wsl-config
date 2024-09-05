-- Syntax Highlighting
require 'nvim-treesitter.configs'.setup {
  sync_install = true,

  ensure_installed = { 'c', 'html', 'cpp', 'go', 'markdown', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'elixir' },

  auto_install = true,

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },

  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
    filetypes = { "html", "xml", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  }
}
