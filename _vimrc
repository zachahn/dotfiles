" vim: syntax=vim

set nocompatible

let mapleader = ","
let maplocalleader = ";"

call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'croaky/vim-colors-github'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'kchmck/vim-coffee-script'
Plug 'lambdatoast/elm.vim'
Plug 'mattn/emmet-vim'
Plug 'rking/ag.vim'
Plug 'slim-template/vim-slim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'chaoren/vim-wordmotion'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'junegunn/fzf', { 'dir': '~/.vim/fzf', 'do': './install --bin' }

" tabular must come before vim-markdown
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
call plug#end()

" load sensible configs early
runtime! plugin/sensible.vim

" style
colorscheme github
set guifont=Meslo\ LG\ S\ for\ Powerline:h14

set foldmethod=indent   " fold based on indent
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " dont fold by default
set foldlevel=1         " this is just what i use

let g:lightline = {
      \ 'colorscheme': 'Tomorrow',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
    \ }

" show relative line numbers, but show real line number on active line
set number
set relativenumber
augroup relativenumber_in_normal_mode
  autocmd!
  autocmd InsertEnter * :set number
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set number
  autocmd InsertLeave * :set relativenumber
augroup END

augroup my_file_types
  autocmd FileType gitcommit setlocal spell
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

runtime! init/**/*.vim

" Red blocks for whitespace on EOL
highlight WhitespaceEOL ctermbg=Red guibg=Red
match WhitespaceEOL /\s\+$/

" Pink underlines on tabs
highlight TabCharacters ctermfg=LightMagenta cterm=underline
highlight TabCharacters guifg=LightMagenta gui=underline
2match TabCharacters /^\t\+/

" show ruler at line 80
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=LightMagenta

  augroup show_ruler_in_active_window
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
  augroup END
endif

" create new buffers at the bottom or right of current active buffer
set splitbelow
set splitright

set cmdheight=2

" netrw
let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

nnoremap - :<C-U>Explore<CR>

let test#strategy = "dispatch"

let g:vim_markdown_folding_disabled=1


" better tab complete
set wildmode=longest,list,full

set linebreak

" set scrolloff=999
set scrolloff=7

augroup unlist_quickfix_from_buffer_list
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

set hlsearch

set ignorecase
set smartcase

let g:wordmotion_prefix = '<Leader>'

nnoremap <C-P> :<C-U>FZF<CR>

" switching buffers
set hidden
map <TAB>   :bnext<CR>
map <S-TAB> :bprev<CR>

" navigating splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" clear highlighting of :set hlsearch (from sensible)
nnoremap <silent> <Leader>c :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" ctrl y will copy text to clipboard
vnoremap <C-Y> :w<Space>!pbcopy<Return><Return>

" delete buffer without removing split
nmap <Leader>bd :b#<bar>bd#<CR>

nmap <Leader>t :TestNearest<CR>
nmap <Leader>T :TestFile<CR>
nmap <Leader>a :TestSuite<CR>
nmap <Leader>l :TestLast<CR>
nmap <Leader>g :TestVisit<CR>
