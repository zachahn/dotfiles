let mapleader = ","
let maplocalleader = ";"

map \  :NERDTreeToggle<CR>
map \| :NERDTreeFind<CR>

" switching buffers
set hidden
map <TAB>   :bnext<CR>
map <S-TAB> :bprev<CR>

" buffergator
nnoremap <silent> <Leader>\ :BuffergatorToggle<CR>
