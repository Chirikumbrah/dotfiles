" Settings
set autochdir
set cursorline
set gp=git\ grep\ -n
set guioptions-=T guioptions-=m guioptions-=r
set hidden
set incsearch hlsearch ignorecase
set lazyredraw
set list lcs=tab:»·,eol:↵,multispace:·,lead:·,trail:·,nbsp:·
set nocompatible
set foldmethod=indent nofoldenable
set number relativenumber
set path+=**
set ruler
set sidescrolloff=11 scrolloff=11
set expandtab tabstop=4 softtabstop=4 shiftwidth=4 smarttab
set signcolumn=yes
set smartcase
set splitbelow splitright
set timeoutlen=20
set wildmenu
if (has("termguicolors"))
    set termguicolors
endif

syntax on
filetype plugin indent on

" Global Variables
let g:netrw_banner=0
let g:netrw_altv=1 " open splits to the right
let g:netrw_preview=1 " preview split to the right
let g:netrw_liststyle=3 " tree view
let g:lsp_diagnostics_virtual_text_enabled=0
let g:lsp_diagnostics_highlights_enabled=0

" Undofile Options
if !isdirectory($HOME."/.cache/vim-undodir")
    call mkdir($HOME."/.cache/vim-undodir", "", 0700)
endif
set undodir=~/.cache/vim-undodir
set undofile

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

"""""" Plugins """""
packadd! matchit

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Colorscheme
Plug 'ericbn/vim-solarized'

call plug#end()

function! OnLspBufferEnabled() abort
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


"""""" Colorscheme """""
set background=dark
silent! colorscheme solarized
if &background == "dark" && exists('g:colors_name') && g:colors_name ==# 'solarized'
    hi SpecialKey guibg=NONE guifg=#374549
    hi NonText guibg=NONE guifg=#374549
else
    hi SpecialKey guibg=NONE guifg=#D6D0BF
    hi NonText guibg=NONE guifg=#D6D0BF
endif
