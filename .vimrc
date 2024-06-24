" Settings
filetype plugin indent on
set cursorline
set foldmethod=expr
set gp=git\ grep\ -n
set hidden
set hlsearch
set ignorecase
set incsearch
set number
set relativenumber
set ruler
set shiftwidth=4 smarttab
set smartcase
set spell
set tabstop=4
set undofile
set wildignore=*.exe,*.dll,*.pdb
set wildmenu
syntax on

"""""" Remaps """""
nnoremap <silent> <Esc> <Esc>:noh<CR>


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

" Autocompletion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Colorscheme
Plug 'altercation/vim-colors-solarized'

call plug#end()


let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

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


"""""" Colors """""
silent! colorscheme solarized
set background=dark
