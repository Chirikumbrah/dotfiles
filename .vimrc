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
set number
set ruler
set shiftwidth=4 smarttab
set smartcase
set spell
set tabstop=4
set wildmenu
set ambw=double
syntax on

" Let's save undo info!
if !isdirectory($HOME."/.cache/vim-undodir")
	call mkdir($HOME."/.cache/vim-undodir", "", 0700)
endif
set undodir=~/.cache/vim-undodir
set undofile


"""""" Remaps """""
nnoremap <silent> <Esc> <Esc>:noh<CR>


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
	Plug 'towolf/vim-helm'

	" Autocompletion
	" Plug 'prabirshrestha/asyncomplete.vim'
	" Plug 'prabirshrestha/asyncomplete-lsp.vim'

	" Colorscheme
	Plug 'morhetz/gruvbox'

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

function! FlashYankedText()
	if (!exists('g:yankedTextMatches'))
		let g:yankedTextMatches = []
	endif

	let matchId = matchadd('IncSearch', ".\\%>'\\[\\_.*\\%<']..")
	let windowId = winnr()

	call add(g:yankedTextMatches, [windowId, matchId])
	call timer_start(300, 'DeleteTemporaryMatch')
endfunction

function! DeleteTemporaryMatch(timerId)
	while !empty(g:yankedTextMatches)
		let match = remove(g:yankedTextMatches, 0)
		let windowID = match[0]
		let matchID = match[1]

		try
			call matchdelete(matchID, windowID)
		endtry
	endwhile
endfunction


"""""" Autocommands """""
augroup highlightYankedText
	autocmd!
	autocmd TextYankPost * call FlashYankedText()
augroup END


"""""" Colors """""
silent! colorscheme gruvbox
