command! -nargs=* Figlet call FigletFigletTrioTrioTrio(<q-args>)

function! FigletFigletTrioTrioTrio(cmd_args)
  let cmd = 'figlet ' . a:cmd_args
  " run the figlet command!
  let output = system(cmd)
  " remove the final newline
  let output = substitute(output, '\n$', '', '')
  " make each line start with a # (except the first)
  let output = substitute(output, '\n', '\n# ', 'g')
  " make the first line start with a #
  let output = substitute(output, '^', '# ', 'g')
  " remove trailing whitespace, on all lines except the last
  let output = substitute(output, '\s\+\n', '\n', 'g')
  " remove trailing whitespace on the last line, and add a trailing newline
  let output = substitute(output, '\s\+$', '\n', 'g')

  $put=output
endfunction
