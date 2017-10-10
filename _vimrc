" vim: syntax=vim

set nocompatible

let mapleader = ' '
let maplocalleader = '\'

call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'croaky/vim-colors-github'
Plug 'ekalinin/Dockerfile.vim'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'kchmck/vim-coffee-script'
Plug 'lambdatoast/elm.vim'
Plug 'mattn/emmet-vim'
Plug 'zachahn/vim-ack-ag'
Plug 'mileszs/ack.vim'
Plug 'slim-template/vim-slim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'sunaku/vim-ruby-minitest'
Plug 'rust-lang/rust.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'pangloss/vim-javascript'
Plug 'sjl/gundo.vim'
Plug 'mxw/vim-jsx'
Plug 'junegunn/fzf', { 'dir': '~/.vim/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" tabular must come before vim-markdown
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
call plug#end()

" load sensible configs early
runtime! plugin/sensible.vim
runtime! plugin/sleuth.vim

" style
try
  colorscheme github
catch
  colorscheme default
endtry

highlight WhitespaceEOL ctermbg=Red guibg=Red
match WhitespaceEOL /\s\+$/

highlight TabCharacters ctermfg=LightMagenta cterm=underline guifg=LightMagenta gui=underline
2match TabCharacters /^\t\+/

set number

augroup my_file_types
  autocmd!
  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitcommit setlocal colorcolumn=72

  autocmd FileType haskell setlocal shiftwidth=4 tabstop=4 expandtab

  autocmd FileType markdown setlocal spell
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 expandtab

  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 expandtab

  autocmd FileType eruby setlocal shiftwidth=2 tabstop=2 expandtab

  autocmd FileType qf set nobuflisted
  autocmd FileType qf setlocal nowrap
augroup END

if (exists('+colorcolumn'))
  set colorcolumn=80 " show ruler on startup
  highlight ColorColumn ctermbg=LightMagenta

  augroup show_ruler_only_in_active_window
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
  augroup END
endif

command! -bang FuzzySilver call fzf#run(fzf#wrap('ag-fzf', { 'source': 'ag --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"' }, <bang>0))
command! Gignorant Dispatch git ignorant
command! Vsplit botright vsplit
command! Split botright split
command! Vs Vsplit
command! Sp Split

set splitbelow " create buffer at the bottom of active buffer
set splitright " create buffer at the right of active buffer
set wildmode=longest,list,full
set linebreak
set scrolloff=7
set hlsearch
set hidden
set foldmethod=indent   " fold based on indent
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " dont fold by default
set foldlevel=1         " this is just what i use
set ignorecase
set smartcase
set cmdheight=2
set shellpipe=2>&1\|\ tee\ 

let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_bufsettings = 'nomodifiable nomodified number nobuflisted nowrap readonly'
let test#strategy = 'dispatch'
let g:vim_markdown_folding_disabled=1
let g:wordmotion_prefix = '<Leader>'
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~40%' }

let g:lightline = {
  \ 'colorscheme': 'Tomorrow',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'fugitive', 'filename', 'modified' ]
  \   ]
  \ },
  \ 'component': {
  \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
  \ },
  \ 'component_visible_condition': {
  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
  \ },
\ }

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
\ }

nnoremap - :<C-U>Explore<CR>
nnoremap <C-P> :<C-U>FuzzySilver<CR>

" navigating and manipulating buffers, splits, tabs
nnoremap <TAB>   :bnext<CR>
nnoremap <S-TAB> :bprev<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap _ :FzfBuffer<CR>
nnoremap <Leader>te :tabe %<CR>
nnoremap <Leader>tq :tabc<CR>

" redraw and nohl (from vim-sensible)
nnoremap <silent> <Leader>l :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

noremap <Leader>y "*y

nnoremap <Leader><space> @q

" delete buffer without removing split
nnoremap <Leader>bd :b#<bar>bd#<CR>

nnoremap <Leader>tt :TestNearest<CR>
nnoremap <Leader>tf :TestFile<CR>
nnoremap <Leader>ts :TestSuite<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tv :TestVisit<CR>

nnoremap <Leader>ve :tabe $MYVIMRC<CR>
nnoremap <Leader>vs :source $MYVIMRC<CR>

nnoremap <Leader>cc :sp<CR><C-]>
nnoremap <Leader>cv :vs<CR><C-]>

nnoremap <Leader>u :GundoToggle<CR>

inoremap jk <Esc>
