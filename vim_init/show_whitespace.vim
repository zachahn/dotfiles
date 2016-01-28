" Red blocks for whitespace on EOL
highlight WhitespaceEOL ctermbg=Red guibg=Red
match WhitespaceEOL /\s\+$/

" Pink underlines on tabs
highlight TabCharacters ctermfg=LightMagenta cterm=underline
highlight TabCharacters guifg=LightMagenta gui=underline
2match TabCharacters /^\t\+/
