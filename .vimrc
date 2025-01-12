" Options
set expandtab tabstop=4 softtabstop=4 shiftwidth=4 smarttab
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
set scrolloff=11
set showcmd
set smartcase
set splitbelow splitright
set termguicolors
set wildignore=*.o,*.tgz,*.pyc
set wildmenu

" Plugins
packadd! matchit

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin()

Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

call plug#end()

" Variables
let mapleader = " "
let c_comment_strings=1 " Highlighting strings inside C comments.
let g:netrw_banner=0        " disable annoying banner
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_fastbrowse = 0 " close NetRW after opening a file


" Mappings
" clear highlights with ESC
nnoremap <silent> <esc> :noh<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>g :Rg<CR>
nnoremap <silent> <leader>o :History<CR>

" Autocommands

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>r <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

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
augroup END


silent! colorscheme habamax
