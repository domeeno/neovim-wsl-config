-- Syntax Highlighting
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'elixir' },


  sync_install = false,

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
    filetypes = { "html", "xml" },
  }
}
