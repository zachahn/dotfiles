let g:ctrlp_custom_ignore = '\v\/coverage\/'

let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_switch_buffer = 0

let g:ctrlp_by_filename = 1

if executable('ag')
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  let g:ctrlp_use_caching = 0
endif
