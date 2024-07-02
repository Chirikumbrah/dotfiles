" Settings
filetype plugin indent on
set cursorline
set foldmethod=indent
set nofoldenable
set gp=git\ grep\ -n
set hidden
set hlsearch
set ignorecase
set incsearch
set nocompatible
set number
set ruler
set lazyredraw
set shiftwidth=4 smarttab
set smartcase
set spell
set tabstop=4
set wildmenu
set path+=**
set timeoutlen=20
syntax on


" Let's save undo info!
if !isdirectory($HOME."/.cache/vim-undodir")
    call mkdir($HOME."/.cache/vim-undodir", "", 0700)
endif
set undodir=~/.cache/vim-undodir
set undofile



"""""" Plugins """""

packadd! matchit

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"""""" Functions """""

function InitLspPlugins()
    call plug#begin()

    " LSP
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'

    call plug#end()
endfunction

" If you want just a simple Vim config with no plugins, just comment the
" following line
call InitLspPlugins()

" By default I want no LSP, sometimes when needed, I can simply call StartLsp
" to start it
function g:StartLsp()
    function! OnLspBufferEnabled() abort
        setlocal omnifunc=lsp#complete
        setlocal signcolumn=yes
        highlight clear SignColumn
        nmap <buffer> gi <plug>(lsp-definition)
        nmap <buffer> gd <plug>(lsp-declaration)
        nmap <buffer> gr <plug>(lsp-references)
        nmap <buffer> gl <plug>(lsp-document-diagnostics)
        nmap <buffer> <f2> <plug>(lsp-rename)
        nmap <buffer> <S-K> <plug>(lsp-hover)
    endfunction

    augroup lsp_install
        au!
        autocmd User lsp_buffer_enabled call OnLspBufferEnabled()
    augroup END
endfunction

" Open file on the last position
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

colorscheme desert
hi Normal guibg=NONE ctermbg=NONE
