set cursorline
set gp=git\ grep\ -n
set path+=**
set hidden
set incsearch hlsearch
set ignorecase
set nocompatible
set number "relativenumber
set ruler
set expandtab tabstop=4 softtabstop=4 shiftwidth=4 smarttab
set smartcase
set timeoutlen=20
set wildmenu
set wildignore=*.o,*.tgz,*.pyc
set termguicolors
set noswapfile nowritebackup
set paste
set laststatus=2
" set spell

syntax on
filetype plugin indent on

if !isdirectory($HOME."/.cache/vim-undodir")
    call mkdir($HOME."/.cache/vim-undodir", "p", 0700)
endif
set undodir=~/.cache/vim-undodir
set undofile

map <silent> <esc> :noh <CR>

autocmd BufWritePre * %s/\s\+$//e " Remove trailing whitespace

autocmd BufRead,BufNewFile */templates/*.y*ml,*/templates/*.tpl set filetype=helm " Detect Helm templates as helm filetype

augroup helm_syntax " Define syntax and indentation for helm filetype
  autocmd!
  autocmd FileType helm setlocal syntax=yaml
augroup END


packadd! matchit

silent! colorscheme habamax
