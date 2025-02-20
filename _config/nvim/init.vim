" vim: ft=vim

set nocompatible

let &runtimepath.=',~/.vim'

let mapleader = ' '
let maplocalleader = '\'

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
" Core dependencies
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'neovim/nvim-lspconfig'

" UI
Plug 'acarapetis/vim-colors-github'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'f-person/auto-dark-mode.nvim'

" Navigation
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.vim/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree' " Navigating mistakes
Plug 'tpope/vim-projectionist' " Jumping to alternate files with :A

" Syntax
Plug 'tpope/vim-sleuth' " Automatically set indentation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise' " Add end to the end
Plug 'aliva/vim-fish', { 'for': 'fish' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'mracos/mermaid.vim', { 'for': 'mermaid' }
Plug 'timcharper/textile.vim', { 'for': 'textile' }
Plug 'keith/swift.vim', { 'for': 'swift' }

" Ruby
Plug 'AndrewRadev/splitjoin.vim', { 'for': 'ruby' }
Plug 'tpope/vim-rails'

" Various utilities
Plug 'mattn/emmet-vim', { 'for': ['eruby', 'html'] }
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tpope/vim-abolish' " Converting to camel case, etc
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tpope/vim-rhubarb' " GitHub integration
Plug 'tpope/vim-rsi' " Things like C-a to go home, C-e to go end
Plug 'tpope/vim-unimpaired' " Pairs of bracket (as in []) maps

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

if filereadable(expand('~/.config/nvim/vimrc_plugins_local'))
  source $HOME/.config/nvim/vimrc_plugins_local
endif
call plug#end()

" load these early so that they could be overridden
runtime! plugin/sensible.vim
runtime! plugin/sleuth.vim

set list
set listchars=tab:‗‗
match errorMsg /\s\+$/

try
  colorscheme github
catch
  colorscheme default
endtry

augroup let_me_switch_buffers_without_saving
  autocmd!
  autocmd BufEnter,BufWinEnter * set hidden
augroup END

command! Gjedi Dispatch git jedi
command! Vsplit botright vsplit
command! Split botright split
command! Vs Vsplit
command! Sp Split
command! Wq x
command! Wqa xa
command! Qa qa
command! -nargs=1 Read 0read ~/.vim/templates/<args> | %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge

set commentstring=#\ %s
set number
set splitbelow " create buffer at the bottom of active buffer
set splitright " create buffer at the right of active buffer
set wildmode=longest,list,full
set linebreak
set scrolloff=3
set hlsearch
set nofoldenable
set ignorecase " Ignorecase and smartcase work together
set smartcase
set cmdheight=2
set shellpipe=2>&1\|\ tee\ 
set nojoinspaces
set mouse=

source $HOME/.vim/more/ack.vim
source $HOME/.vim/more/base64.vim
source $HOME/.vim/more/caps.vim
source $HOME/.vim/more/colorcolumn.vim
source $HOME/.vim/more/figlet.vim
source $HOME/.vim/more/filetypes.vim
source $HOME/.vim/more/fzf.vim
source $HOME/.vim/more/lightline.vim
source $HOME/.vim/more/netrw.vim
source $HOME/.vim/more/projectionist.vim
source $HOME/.config/nvim/lua/config/lsp.lua

if executable('gtar')
  let g:tar_cmd='/usr/local/bin/gtar'
endif

let g:markdown_fenced_languages = ['html', 'ruby', 'bash=sh', 'sh', 'mermaid']

" Perform case-sensitive searches when searching with `*` or `#`
nnoremap * /\<<C-R>=expand('<cword>')<CR>\>\C<CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>

" navigating and manipulating buffers, splits, tabs
nnoremap <TAB>   :bnext<CR>
nnoremap <S-TAB> :bprev<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap _ :FzfBuffer<CR>

" redraw and nohl (from vim-sensible)
nnoremap <silent> <Leader>l :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

noremap <Leader>y "*y

nnoremap <Leader><space> @q

" delete buffer without removing split
nnoremap <Leader>bd :b#<bar>bd#<CR>

nnoremap <Leader>u :UndotreeToggle<CR>

inoremap jk <Esc>
inoremap Jk <Esc>

inoremap <CR> <C-G>u<CR>

vnoremap < <gv
vnoremap > >gv

nnoremap H <Nop>
nnoremap M <Nop>
nnoremap L <Nop>
vnoremap K <Nop>

nnoremap <Del> l

iabbrev javascript JavaScript
iabbrev Javascript JavaScript

if filereadable(expand('~/.config/nvim/vimrc_local'))
  source $HOME/.config/nvim/vimrc_local
endif

lua require("config/auto_dark_mode")
lua require("config/treesitter")
