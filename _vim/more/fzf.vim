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

if executable('rg')
  command! -bang FuzzyRip call fzf#run(fzf#wrap('rg-fzf', { 'options': '--multi', 'source': 'rg --files --ignore-vcs --sort-files' }, <bang>0))
  nnoremap <C-P> :<C-U>FuzzyRip<CR>
else
  command! -bang FuzzySilver call fzf#run(fzf#wrap('ag-fzf', { 'options': '--multi', 'source': 'ag --files-with-matches --filename-pattern "" --ignore "\.git$\|\.hg$\|\.svn$" --skip-vcs-ignores' }, <bang>0))
  nnoremap <C-P> :<C-U>FuzzySilver<CR>
endif
