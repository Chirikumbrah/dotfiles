" Settings
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
"set signcolumn=yes
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

" Undofile Options
if !isdirectory($HOME."/.cache/vim-undodir")
    call mkdir($HOME."/.cache/vim-undodir", "p", 0700)
endif
set undodir=~/.cache/vim-undodir
set undofile


"""""" Mappings """""
map <silent> <esc> :noh <CR>


"""""" Autocommands """""
" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
"autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

" Detect Helm templates as helm filetype
autocmd BufRead,BufNewFile */templates/*.y*ml,*/templates/*.tpl set filetype=helm

" Define syntax and indentation for helm filetype
augroup helm_syntax
  autocmd!
  autocmd FileType helm setlocal syntax=yaml
augroup END


"""""" Plugins """""
packadd! matchit

" let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
" if empty(glob(data_dir . '/autoload/plug.vim'))
"     silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"     autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" call plug#begin()

" Colorscheme
" Plug 'ericbn/vim-solarized'

" call plug#end()


"""""" Colorscheme """""
"set background=dark
silent! colorscheme habamax
