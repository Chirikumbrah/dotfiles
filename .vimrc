set nocompatible
filetype on
filetype plugin on
filetype indent on
set cursorline
set cursorcolumn
set number
set relativenumber
syntax on
set tabstop=4 
set shiftwidth=4
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set mouse=a
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}
