set imsearch=-1
set keymap=insert_caps

augroup auto_exit_insert_caps
  autocmd!
  autocmd BufEnter,BufWinEnter * set iminsert=0
  autocmd InsertLeave * set iminsert=0
augroup END
