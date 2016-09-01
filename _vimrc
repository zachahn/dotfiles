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
Plug 'mileszs/ack.vim'
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
Plug 'sjl/gundo.vim'
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

highlight WhitespaceEOL ctermbg=Red guibg=Red
match WhitespaceEOL /\s\+$/

highlight TabCharacters ctermfg=LightMagenta cterm=underline guifg=LightMagenta gui=underline
2match TabCharacters /^\t\+/

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

set number
set relativenumber
augroup show_relative_line_numbers_but_absolute_on_active_line_and_insert_mode
  autocmd!
  autocmd InsertEnter * :set number
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set number
  autocmd InsertLeave * :set relativenumber
augroup END

augroup my_file_types
  autocmd!
  autocmd FileType gitcommit setlocal spell
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType qf set nobuflisted
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
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

if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

command! -bang AgFZF call fzf#run(fzf#wrap('ag-fzf', { 'source': 'ag --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"' }, <bang>0))
command! Gignorant Dispatch git ignorant
command! -bang -nargs=* -complete=file Ag           call ack#Ack('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgAdd        call ack#Ack('grepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgFromSearch call ack#AckFromSearch('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAg          call ack#Ack('lgrep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAgAdd       call ack#Ack('lgrepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgFile       call ack#Ack('grep<bang> -g', <q-args>)
command! -bang -nargs=* -complete=help AgHelp       call ack#AckHelp('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=help LAgHelp      call ack#AckHelp('lgrep<bang>', <q-args>)
command! -bang -nargs=*                AgWindow     call ack#AckWindow('grep<bang>', <q-args>)
command! -bang -nargs=*                LAgWindow    call ack#AckWindow('lgrep<bang>', <q-args>)

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

let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let test#strategy = "dispatch"
let g:vim_markdown_folding_disabled=1
let g:wordmotion_prefix = '<Leader>'
let g:ack_use_dispatch = 1

nnoremap - :<C-U>Explore<CR>
nnoremap <C-P> :<C-U>AgFZF<CR>

" switching buffers
nnoremap <TAB>   :bnext<CR>
nnoremap <S-TAB> :bprev<CR>

" navigating splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" clear highlighting of :set hlsearch (from sensible)
nnoremap <silent> <Leader>l :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

noremap <Leader>y "*y

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
