if filereadable(expand("~/.vimrc_bundles"))
  source ~/.vimrc_bundles
endif

" load sensible configs early
runtime! plugin/sensible.vim

autocmd FileType gitcommit setlocal spell

runtime! init/**.vim


" better tab complete
set wildmode=longest,list,full

set linebreak

" set scrolloff=999
set scrolloff=7

filetype plugin on

if has("mouse")
	set mouse=a
	set mousehide
endif

set hlsearch
