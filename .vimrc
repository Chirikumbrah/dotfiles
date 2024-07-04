" Settings
filetype plugin indent on
set autochdir
set cursorline
set expandtab
set foldmethod=indent
set gp=git\ grep\ -n
set guioptions-=T
set guioptions-=m
set guioptions-=r
set hidden
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set nocompatible
set nofoldenable
set number
set path+=**
set relativenumber
set ruler
set scrolloff=11
set shiftwidth=4 smarttab
set sidescrolloff=11
set signcolumn=yes
set smartcase
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set timeoutlen=20
set wildmenu
if (has("termguicolors"))
    set termguicolors
endif
syntax on

" NetRW options
let g:netrw_banner=0
let g:netrw_altv=1 " open splits to the right
let g:netrw_preview=1 " preview split to the right
let g:netrw_liststyle=3 " tree view

" Let's save undo info!
if !isdirectory($HOME."/.cache/vim-undodir")
    call mkdir($HOME."/.cache/vim-undodir", "", 0700)
endif
set undodir=~/.cache/vim-undodir
set undofile

autocmd BufWritePre * %s/\s\+$//e

"""""" Plugins """""

packadd! matchit

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"""""" Functions """""
function InitPlugins()
    call plug#begin()

    " LSP
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'

    " Colorscheme
    Plug 'ericbn/vim-solarized'
    " Plug 'morhetz/gruvbox'

    call plug#end()
endfunction

" If you want just a simple Vim config with no plugins, just comment the
" following line
call InitPlugins()

" By default I want no LSP, sometimes when needed, I can simply call StartLsp
" to start it
function g:StartLsp()
    function! OnLspBufferEnabled() abort
        let g:lsp_diagnostics_virtual_text_enabled=0
        let g:lsp_diagnostics_highlights_enabled=0
        setlocal omnifunc=lsp#complete
        nmap <buffer> gi <plug>(lsp-definition)
        nmap <buffer> gd <plug>(lsp-declaration)
        nmap <buffer> gR <plug>(lsp-references)
        nmap <buffer> gl <plug>(lsp-document-diagnostics)
        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> K <plug>(lsp-hover)
        nmap <buffer> gs <plug>(lsp-document-symbol-search)
        nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
        nmap <buffer> <f2> <plug>(lsp-rename)
        nmap <buffer> [g <plug>(lsp-previous-diagnostic)
        nmap <buffer> ]g <plug>(lsp-next-diagnostic)
        nmap <buffer> K <plug>(lsp-hover)
    endfunction

    augroup lsp_install
        au!
        autocmd User lsp_buffer_enabled call OnLspBufferEnabled()
    augroup END
endfunction

call StartLsp()

set background=dark
" silent! colorscheme gruvbox
" highlight clear SignColumn
silent! colorscheme solarized
