if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9

  augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
  augroup END
endif
