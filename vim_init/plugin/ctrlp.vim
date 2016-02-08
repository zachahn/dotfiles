let g:ctrlp_custom_ignore = '\v\/coverage\/'

if executable('ag')
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  let g:ctrlp_use_caching = 0
endif
