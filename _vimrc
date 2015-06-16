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

" better tab complete
set wildmode=longest,list,full

" relative line numbers
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
autocmd InsertLeave * :set nonumber
" set so=999
set so=7

filetype plugin on

" UI
colorscheme github
set guifont=Meslo\ LG\ S\ for\ Powerline:h14

let g:bufferline_echo = 0
let g:bufferline_rotate = 1
let g:bufferline_fixed_index = 0
let g:airline_theme='sol'
let g:airline_powerline_fonts = 1

" a.vim

let g:alternateExtensions_coffee = 'js'
let g:alternateExtensions_js = 'coffee'

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
