if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
endif

if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case'
  let g:ack_use_dispatch = 0
else
  let g:ackprg = 'ag --vimgrep'
  let g:ack_use_dispatch = 1
endif

command! -bang -nargs=* -complete=file Ag           call ack#Ack('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgAdd        call ack#Ack('grepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgFromSearch call ack#AckFromSearch('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAg          call ack#Ack('lgrep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAgAdd       call ack#Ack('lgrepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgFile       call ack#Ack('grep<bang> -g', <q-args>)
command! -bang -nargs=* -complete=help AgHelp       call ack#AckHelp('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=help LAgHelp      call ack#AckHelp('lgrep<bang>', <q-args>)
command! -bang -nargs=*                AgWindow     call ack#AckWindow('grep<bang>', <q-args>)
command! -bang -nargs=*                LAgWindow    call ack#AckWindow('lgrep<bang>', <q-args>)

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
