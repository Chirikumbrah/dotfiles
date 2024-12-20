set autoindent expandtab tabstop=4 softtabstop=4 shiftwidth=4 smarttab
set backspace=indent,eol,start
set cursorline cursorcolumn
set gp=git\ grep\ -n
set hidden ignorecase
set incsearch hlsearch
set laststatus=2
set list listchars=tab:»\ ,nbsp:·,trail:·
set nocompatible
set noswapfile nowritebackup
set number
set path+=**
set ruler
set showcmd
set smartcase
set splitbelow splitright
set termguicolors
set wildignore=*.o,*.tgz,*.pyc
set wildmenu

syntax on
filetype plugin indent on

let c_comment_strings=1 " Highlighting strings inside C comments.
let g:netrw_banner=0        " disable annoying banner
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Clear highlights with ESC
map <silent> <esc> :noh<CR>

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

augroup yamlcmds
    autocmd BufRead,BufNewFile */templates/*.y*ml,*/templates/*.tpl set filetype=helm " Detect Helm templates as helm filetype
    autocmd FileType helm setlocal syntax=yaml " Define syntax and indentation for helm filetype
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufWritePre *.yml,*.yaml,*.tpl silent! %s/^\(\s*\)#\(\S\)/\1# \2/g " Insert space after first '#' sign in the line
    autocmd BufWritePre *.yml,*.yaml,*.tpl silent! %s/^\(\s*\)-\(\S\)/\1- \2/g " Insert space after first dash in the line
augroup END

packadd! matchit

silent! colorscheme habamax
