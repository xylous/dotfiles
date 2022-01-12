" Enable folding in vimrc
" vim:fdm=marker

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
" PLUGINS {{{
" Plugins (with vim-plug) {{{
" Install vim-plug if not already installed
let plug_install_path = $HOME . "/.local/share/nvim/site/autoload/plug.vim"
let plug_install_now = 0
if ! filereadable(plug_install_path)
    echon 'Installing junegunn/vim-plug...'
    let curloutput = system('curl -fLo '
        \ . plug_install_path
        \ . ' --create-dirs'
        \ . ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    echon ' done'
    let plug_install_now = 1
endif
unlet plug_install_path

" Set runtime path to include vim-plug and initialize
call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
" NOTE: Be careful, as too many plugins will slow vim down!
" Lean status/tabline for vim:
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Quickly comment out multile lines:
Plug 'preservim/nerdcommenter'
" Code autocompletion:
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Snippets for coc-snippets:
Plug 'honza/vim-snippets'
" Find files quickly:
Plug 'junegunn/fzf.vim'
" Provides syntax highlighting and other good stuff
Plug 'nvim-treesitter/nvim-treesitter'
" Plugin for visually displaying indent levels:
Plug 'nathanaelkane/vim-indent-guides'
" Basically, a more conservative version of vim-auto-pairs:
Plug 'rstacruz/vim-closer'
" Display a git diff in the sign column on the left:
Plug 'airblade/vim-gitgutter'
" Colorscheme
Plug 'dracula/vim'
" For Zettelkasten purposes
Plug 'xylous/wikilinks.vim'
Plug 'xylous/settle.vim'
" add plugins only above this line
call plug#end()

if plug_install_now
    execute 'PlugInstall'
    unlet plug_install_now
endif
" }}}
" fzf {{{
" Jump to the existing window if possible
let g:fzf_buffers_jump = 1
let g:fzf_command_prefix = "FZF"

" Use CTRL-f to open FZF quickly, in the home directory
nnoremap <C-f> :FZFFiles .<cr>
nnoremap <leader><C-f> :FZFFiles ~<cr>
" }}}
" Wikilinks.vim {{{
let g:wikilinks_map_key = '<CR>'
" }}}
" coc.nvim {{{
" Use <tab> for trigger completion, completion confirm, snippet expand
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" List of extensions
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-snippets', 'coc-clangd', 'coc-sh', 'coc-rust-analyzer']

" Integrate coc.nvim with Airline
let g:airline#exxtensions#coc#enabled = 1

" Use C syntax highlighting in header files
let g:c_syntax_for_h = 1

" Use <C-j> to jump to next placeholder, <C-k> to jump to previous placeholder;
" it's default of coc.nvim
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'
" }}}
" Indent Guides {{{
let g:indent_guides_enable_on_vim_startup = 1

" Only one character long
let g:indent_guides_guide_size = 1
" }}}
" nvim-treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c",
        "rust",
        "haskell",
        "bash",
        "typescript",
        "json",
        "toml",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
}
EOF
" }}}
" GitGutter {{{
let g:gitgutter_map_keys = 0
" }}}
" }}}
" LOOK AND FEEL {{{
" Assume this is a 256-colour-capable terminal
set t_Co=256

" Enable 24-bit colour (truecolour)
set termguicolors

" Statusline takes care of displaying the mode already
set noshowmode

" Remove the visual delay when switching between modes
set ttimeoutlen=10

set background=dark

" At last, set the theme
colorscheme dracula
" AIRLINE {{{
let g:airline_theme = 'dracula'

" Separators for empty sections look horrifying
let g:airline_skip_empty_sections = 1

" Always show tabs, no matter what
let g:airline#extensions#tabline#enabled = 1

" Sweet, sweet powerline fonts
let g:airline_powerline_fonts = 0

" Define custom symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" Put statusline at the bottom
let g:airline_statusline_ontop = 0

" Define statusline. Uses vim's inbuilt statusline syntax
"let g:airline_section_a = ''
"let g:airline_section_b = ''
"let g:airline_section_c = ''
let g:airline_section_x = '%Y'
"let g:airline_section_y = ''
"let g:airline_section_z = ''
" }}}
" }}}
" KEY BINDINGS {{{
" Use space as leader key
let mapleader = ' '
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
" Create a mark `p`, jump to the beginning of the file, yank until the end in
" the `+` register, go to mark `p`
nnoremap <leader>p :% y+<CR>
" }}}
" AUTOCOMMANDS {{{
augroup MARKDOWN_OPTIONS
    autocmd!
    autocmd BufWinEnter *.md setlocal foldmethod=manual
    autocmd BufWinLeave *.md mkview
    autocmd BufWinEnter *.md silent! loadview
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

" Set custom path for viminfo
set shada='50,<1000,s100,:0,n$XDG_CACHE_HOME/nvim/nviminfo
