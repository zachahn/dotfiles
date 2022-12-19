" vim: syntax=vim

set nocompatible

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
Plug 'tpope/vim-projectionist' " Jumping to alternate files with :A

" UI
Plug 'acarapetis/vim-colors-github'
Plug 'itchyny/lightline.vim'

Plug 'neovim/nvim-lspconfig'

" Navigation
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.vim/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree' " Navigating mistakes

" Syntax
Plug 'aliva/vim-fish', { 'for': 'fish' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'mracos/mermaid.vim', { 'for': 'mermaid' }

" " Ruby
Plug 'AndrewRadev/splitjoin.vim', { 'for': 'ruby' }
Plug 'tpope/vim-rails'

" Various utilities
Plug 'mattn/emmet-vim', { 'for': ['eruby', 'html'] }
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tpope/vim-abolish' " Converting to camel case, etc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise' " Add end to the end
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tpope/vim-rhubarb' " GitHub integration
Plug 'tpope/vim-rsi' " Things like C-a to go home, C-e to go end
Plug 'tpope/vim-sleuth' " Automatically set indentation
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired' " Pairs of bracket (as in []) maps

if filereadable(expand('~/.config/nvim/vimrc_plugins_local'))
  source $HOME/.config/nvim/vimrc_plugins_local
endif
call plug#end()

" load these early so that they could be overridden
runtime! plugin/sensible.vim
runtime! plugin/sleuth.vim

augroup custom_highlights
  autocmd!
  autocmd ColorScheme * highlight TabCharacters ctermfg=LightMagenta cterm=underline guifg=LightMagenta gui=underline
  autocmd BufWinEnter * let w:match_trailing_whitespace=matchadd('ErrorMsg', '\s\+$', -1)
  autocmd BufWinEnter * let w:match_tab_chars=matchadd('TabCharacters', '\t\+', -1)
augroup END

try
  colorscheme github
catch
  colorscheme default
endtry

augroup my_file_types
  autocmd!
  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitcommit setlocal colorcolumn=72

  autocmd FileType haskell setlocal shiftwidth=2 tabstop=2 expandtab

  autocmd FileType markdown setlocal spell
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 expandtab

  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 expandtab

  autocmd FileType eruby setlocal shiftwidth=2 tabstop=2 expandtab

  autocmd FileType qf set nobuflisted
  autocmd FileType qf setlocal nowrap

  autocmd BufNewFile,BufRead * if &filetype ==# '' | set filetype=noft | endif
  autocmd FileType noft setlocal shiftwidth=4 tabstop=4 expandtab

  autocmd BufNewFile,BufRead *.cr set syntax=ruby
  autocmd BufNewFile,BufRead *.cr setfiletype ruby

  autocmd BufNewFile,BufRead *.json.jb set filetype=ruby

  autocmd FileType typescript setlocal commentstring=//\ %s
  autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 expandtab

  autocmd FileType git-revise-todo setlocal textwidth=72
augroup END

augroup let_me_switch_buffers_without_saving
  autocmd!
  autocmd BufEnter,BufWinEnter * set hidden
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

augroup auto_exit_insert_caps
  autocmd!
  autocmd BufEnter,BufWinEnter * set iminsert=0
  autocmd InsertLeave * set iminsert=0
augroup END

command! Gjedi Dispatch git jedi
command! Vsplit botright vsplit
command! Split botright split
command! Vs Vsplit
command! Sp Split
command! Wq x
command! Wqa xa
command! Qa qa
command! -nargs=1 Read 0read ~/.config/nvim/templates/<args> | %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge

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
set imsearch=-1
" set keymap=insert_caps
set nojoinspaces
set mouse=

source $HOME/.vim/misc/ack.vim
source $HOME/.vim/misc/figlet.vim
source $HOME/.vim/misc/fzf.vim
source $HOME/.vim/misc/projectionist.vim

if executable('gtar')
  let g:tar_cmd='/usr/local/bin/gtar'
endif

let g:markdown_fenced_languages = ['html', 'ruby', 'bash=sh', 'sh', 'mermaid']
let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_bufsettings = 'nomodifiable nomodified number nobuflisted nowrap readonly'

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

nnoremap - :<C-U>Explore<CR>

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
nnoremap <Leader>te :tabe %<CR>
nnoremap <Leader>tq :tabc<CR>

" redraw and nohl (from vim-sensible)
nnoremap <silent> <Leader>l :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

noremap <Leader>y "*y

nnoremap <Leader><space> @q

" delete buffer without removing split
nnoremap <Leader>bd :b#<bar>bd#<CR>

nnoremap <Leader>ve :tabe $MYVIMRC<CR>
nnoremap <Leader>vs :source $MYVIMRC<CR>

nnoremap <Leader>cc :sp<CR><C-]>
nnoremap <Leader>cv :vs<CR><C-]>

nnoremap <Leader>u :UndotreeToggle<CR>

inoremap jk <Esc>
inoremap Jk <Esc>

inoremap <CR> <C-G>u<CR>

vnoremap < <gv
vnoremap > >gv

nnoremap H <Nop>
nnoremap M <Nop>
nnoremap L <Nop>
nnoremap K <Nop>
vnoremap K <Nop>

nnoremap <Del> l

iabbrev Javascript JavaScript

vnoremap <Leader>d64 c<c-r>=system('base64 --decode', @")<cr><esc>
vnoremap <Leader>e64 c<c-r>=system('base64', @")<cr><esc>

if filereadable(expand('~/.config/nvim/vimrc_local'))
  source $HOME/.config/nvim/vimrc_local
endif

lua << EOF
require'lspconfig'.sorbet.setup{}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['sorbet'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

EOF
