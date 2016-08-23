let g:ctrlp_custom_ignore = '\v\/coverage\/'

let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_switch_buffer = 0

if executable('ag')
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  let g:ctrlp_use_caching = 0
endif

if has('python')
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" let g:ctrlp_lazy_update = 150
let g:ctrlp_max_files = 0

let g:ctrlp_open_new_file = 'r'
