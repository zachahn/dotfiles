if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile git-revise-todo setfiletype git-revise-todo
augroup END
