" vim: syntax=vim

if filereadable(expand("~/.vimrc_bundles"))
  source ~/.vimrc_bundles
endif

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
