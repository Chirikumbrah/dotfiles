unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set cursorline
set gp=git\ grep\ -n
set path+=**
set hidden
set incsearch hlsearch
set ignorecase
set number
set expandtab tabstop=4 softtabstop=4 shiftwidth=4 smarttab
set smartcase
set timeoutlen=20
set wildignore=*.o,*.tgz,*.pyc
set termguicolors
set noswapfile nowritebackup
set laststatus=2

if !isdirectory($HOME."/.cache/vim-undodir")
    call mkdir($HOME."/.cache/vim-undodir", "p", 0700)
endif
set undodir=~/.cache/vim-undodir
set undofile

let g:netrw_banner=0

map <silent> <esc> :noh <CR>

autocmd BufWritePre * %s/\s\+$//e " Remove trailing whitespace
autocmd BufRead,BufNewFile */templates/*.y*ml,*/templates/*.tpl set filetype=helm " Detect Helm templates as helm filetype
autocmd FileType helm setlocal syntax=yaml " Define syntax and indentation for helm filetype

packadd! matchit

silent! colorscheme habamax
