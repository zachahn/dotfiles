if executable('rg')
  let g:ack_use_dispatch = 0

  if filereadable(".git/rgignore")
    let g:ackprg = 'rg --vimgrep --smart-case --ignore-file=.git/rgignore'
  else
    let g:ackprg = 'rg --vimgrep --smart-case'
  endif

  set grepprg=rg\ --vimgrep\ --smart-case
endif

command! -bang -nargs=* -complete=file Rg           call ack#Ack('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file RgAdd        call ack#Ack('grepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file RgFromSearch call ack#AckFromSearch('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LRg          call ack#Ack('lgrep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LRgAdd       call ack#Ack('lgrepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file RgFile       call ack#Ack('grep<bang> -g', <q-args>)
command! -bang -nargs=* -complete=help RgHelp       call ack#AckHelp('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=help LRgHelp      call ack#AckHelp('lgrep<bang>', <q-args>)
command! -bang -nargs=*                RgWindow     call ack#AckWindow('grep<bang>', <q-args>)
command! -bang -nargs=*                LRgWindow    call ack#AckWindow('lgrep<bang>', <q-args>)
