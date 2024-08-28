require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "ruby", "rust", "yaml" },
}

require'treesitter-context'.setup{
  multiline_threshold = 1,
}
