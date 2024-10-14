let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~40%' }

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
\ }

command! -bang FuzzyRip call fzf#run(fzf#wrap('rg-fzf', { 'options': '--multi --ignore-case', 'source': 'rg --files --ignore-vcs --sort-files' }, <bang>0))
nnoremap <C-P> :<C-U>FuzzyRip<CR>
