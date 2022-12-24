if (exists('+colorcolumn'))
  highlight ColorColumn ctermbg=LightMagenta

  function! s:SetColorColumn()
    if &textwidth == 0
      set colorcolumn=80
    else
      set colorcolumn=+0
    endif
  endfunction

  function! s:UnsetColorColumn()
    set colorcolumn=0
  endfunction

  " show ruler on startup
  call s:SetColorColumn()

  augroup show_ruler_only_in_active_window
    autocmd!
    autocmd OptionSet textwidth call s:SetColorColumn()
    autocmd WinEnter * call s:SetColorColumn()
    autocmd WinLeave * call s:UnsetColorColumn()
  augroup END
endif
