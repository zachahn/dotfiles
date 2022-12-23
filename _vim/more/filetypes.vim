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
