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

let fuzzy_rip_source = 'rg --files --ignore-vcs --sort-files'
if filereadable(".git/rgignore")
  let fuzzy_rip_source = fuzzy_rip_source . ' --ignore-file=.git/rgignore'
endif

command! -bang FuzzyRip call fzf#run(fzf#wrap('rg-fzf', { 'options': '--multi --ignore-case', 'source': fuzzy_rip_source }, <bang>0))
nnoremap <C-P> :<C-U>FuzzyRip<CR>
