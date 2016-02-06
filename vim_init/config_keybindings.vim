let mapleader = ","
let maplocalleader = ";"

" switching buffers
set hidden
map <TAB>   :bnext<CR>
map <S-TAB> :bprev<CR>

" navigating splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" nerdtree
map \  :NERDTreeToggle<CR>
map \| :NERDTreeFind<CR>

" buffergator
nnoremap <silent> <Leader>\ :BuffergatorToggle<CR>

" clear highlighting of :set hlsearch (from sensible)
nnoremap <silent> <Leader>c :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
