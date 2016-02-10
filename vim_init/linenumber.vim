" relative line numbers
set number
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set number
autocmd InsertLeave * :set relativenumber
