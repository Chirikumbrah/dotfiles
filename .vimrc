set autoindent expandtab tabstop=4 softtabstop=4 shiftwidth=4 smarttab
set backspace=indent,eol,start
set cursorline cursorcolumn
set gp=git\ grep\ -n
set hidden
set ignorecase
set incsearch hlsearch
set laststatus=2
set list listchars=tab:»\ ,nbsp:·,trail:·
set nocompatible
set nolangremap
set noswapfile nowritebackup
set number
set path+=**
set ruler
set scrolloff=11
set showcmd
set smartcase
set splitbelow splitright
set termguicolors
set timeoutlen=20
set wildignore=*.o,*.tgz,*.pyc
set wildmenu

syntax on
filetype plugin indent on

let c_comment_strings=1 " Highlighting strings inside C comments.
let g:netrw_banner=0 " Disable netrw banner

" Clear highlights with ESC
map <silent> <esc> :noh <CR>

" When editing a file, always jump to the last known cursor position.
augroup vimStartup
    autocmd!
    autocmd BufReadPost *
                \ let line = line("'\"")
                \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
                \      && index(['xxd', 'gitrebase'], &filetype) == -1
                \ |   execute "normal! g`\""
                \ | endif
augroup END

if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "p", 0700)
endif
set undodir=~/.vim/undodir
set undofile

autocmd BufWritePre * silent! %s/\s\+$//e " Remove trailing whitespace
autocmd BufWritePre * silent! %s/^\(\s*\)#\(\S\)/\1# \2/g " Insert space after first '#' sign in the line
autocmd BufWritePre * silent! %s/^\(\s*\)-\(\S\)/\1- \2/g " Insert space after first dash in the line

augroup yamlcmds
    autocmd BufRead,BufNewFile */templates/*.y*ml,*/templates/*.tpl set filetype=helm " Detect Helm templates as helm filetype
    autocmd FileType helm setlocal syntax=yaml " Define syntax and indentation for helm filetype
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

packadd! matchit

silent! colorscheme habamax
