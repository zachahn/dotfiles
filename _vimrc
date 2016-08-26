" vim: syntax=vim

set nocompatible

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

autocmd FileType gitcommit setlocal spell

runtime! init/**/*.vim


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

nnoremap <C-P> :<C-U>FZF<CR>
