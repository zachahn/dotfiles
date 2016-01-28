if filereadable(expand("~/.vimrc_bundles"))
  source ~/.vimrc_bundles
endif

" load sensible configs early
runtime! plugin/sensible.vim

autocmd FileType gitcommit setlocal spell

if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

runtime! init/**.vim


" better tab complete
set wildmode=longest,list,full

set linebreak

" relative line numbers
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
autocmd InsertLeave * :set nonumber
" set scrolloff=999
set scrolloff=7

filetype plugin on



" switching buffers
set hidden
map <TAB>   :bnext<CR>
map <S-TAB> :bprev<CR>

if has("mouse")
	set mouse=a
	set mousehide
endif

set hlsearch

" Red blocks for whitespace on EOL
highlight WhitespaceEOL ctermbg=Red guibg=Red
match WhitespaceEOL /\s\+$/

" Pink underlines on tabs
highlight TabCharacters ctermfg=LightMagenta cterm=underline
highlight TabCharacters guifg=LightMagenta gui=underline
2match TabCharacters /^\t\+/
