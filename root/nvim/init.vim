" NVIM configuration for the root user. Note that I'm not installing plugins.

" BASIC OPTIONS {{{
" Be in the 21st century already
set nocompatible
filetype plugin indent on
syntax enable
set encoding=utf-8
set noerrorbells

" Don't change default (terminal) cursor
set guicursor=

" Count lines relative to the current one
set number
set relativenumber

" Start scrolling before you reach the margins
set scrolloff=8

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Dedicate one more line to displaying messages
set cmdheight=2

" Always display a vertical bar on the left; if there are any errors deteced by
" language servers, they'll show there
set signcolumn=yes

" INDENTATION {{{
" Don't bother me with manual indentation
set autoindent
set smartindent
set cindent

" Tabs shall be spaces
set expandtab

" 4 space indent should do
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Split lines longer than 80 characters
set wrap
set textwidth=80
set linebreak

" More convenience with tabs
set smarttab
" }}}
" SEARCHING {{{
" Highlight text during search
set incsearch

" ...but remove the highlight after you're done
set nohlsearch

" Don't do case-sensitive searching, unless there are capital letters
set ignorecase
set smartcase
" }}}
" BUFFERS {{{
" Keep any buffers around in the background
set hidden

" No backups, of any kind, whatsoever
set noswapfile
set nobackup
" }}}
" }}}
" KEY BINDINGS {{{
" Use space as leader key
let mapleader = '\'
" Quick access to vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <C-s> :source $MYVIMRC<CR>

" Disable arrow keys
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>
nnoremap <up> <NOP>
nnoremap <down> <NOP>
nnoremap <left> <NOP>
nnoremap <right> <NOP>

" Quickly switch between windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <leader>H :wincmd H<CR>
nnoremap <leader>J :wincmd J<CR>
nnoremap <leader>K :wincmd K<CR>
nnoremap <leader>L :wincmd L<CR>

inoremap <C-c> <NOP>
vnoremap <C-c> <NOP>

" If the filename under cursor doesn't exist, create it and then go to it
nnoremap <leader>gf :e <cfile><cr>

" Unbind backspace in insert mode and delete key. Use `dw` or `db` or `x` in normal mode
inoremap <BS> <NOP>
noremap <DEL> <NOP>

" Copy the entire file to clipboard
nnoremap <leader>p :% y+<CR>

" Faster movement with buffers
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
" Quit a buffer without closing the window it was on
nnoremap <leadeR>bq :bp<bar>sp<bar>bp<bar>bd<cr>
" }}}
" AUTOCOMMANDS {{{
augroup MARKDOWN_OPTIONS
    autocmd!
    autocmd BufWinEnter *.md setlocal foldmethod=manual
    autocmd BufWinLeave *.md mkview
    autocmd BufWinEnter *.md silent! loadview
augroup END

augroup VIMRC_OPTIONS
    autocmd!
    autocmd FileType vim set foldmethod=marker
augroup END

augroup BUFFER_WRITE
    autocmd!
    " Remove trailing whitespace from every line
    autocmd BufWritePre * :mark p
    autocmd BufWritePre * :%s/\s\+$//ge
    autocmd BufWritePre * :'p
    autocmd BufWritePre * :delmarks p
augroup END
" }}}
