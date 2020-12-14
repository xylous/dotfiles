"" NEOVIM
" Requires python2 and python 3 to be installed. Speeds up loading whenever
" nvim is started
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'



"" BASIC VIM OPTIONS
" Be iMproved, required (nvim is always nocompatible)
set nocompatible

" Loads filetype specific plugins and filetype specific indentation
filetype plugin indent on

" Gives visual feedback; highlight syntax
syntax on 

" Each tab is 4 spaces wide 
set tabstop=4

" Uses 4 spaces for each step of (auto)indent
set shiftwidth=4

" Sets the maximum number of columns to 80
set textwidth=80

" Tabs become spaces
set expandtab

" When in front of a line, a <Tab> inserts blanks according to 'shiftwidth'
set smarttab

" Enables automatic C program indenting
set cindent

" Does smart autoindenting when starting a new line
set smartindent

" Searches incrementally; searches case-sensitively only when there is an uppercase
" character in the pattern to search for
set incsearch
set smartcase

" When a buffer is abandoned, it becomes hidden, not unloaded
set hidden

" Displays the number of the line on the left
set number

" Tells Vim not to beep whenever there is an error, but to use visual bells
set visualbell

" Doesn't make backups of any kind
set noswapfile
set nobackup

" Always encodes in UTF-8
set encoding=utf-8

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Allows more space at the bottom for displaying messages
set cmdheight=2

" Don't change default cursor
set guicursor=



"" PLUGINS
" Set runtime path to include Vundle and initialize
set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here'

" NOTE: Be careful, as too many plugins will slow vim down!

" let Vundle manage Vundle, required:
Plugin 'VundleVim/Vundle.vim'
" File system explorer:
Plugin 'preservim/nerdtree'
" Quickly comment out multile lines:
Plugin 'preservim/nerdcommenter'
" Syntax checking and semantic errors in code:
"Plugin 'dense-analysis/ale'
" Code autocompletion
Plugin 'neoclide/coc.nvim'
" Insert or delete brackets, parens, quotes in pair:
Plugin 'jiangmiao/auto-pairs'
" Adds git functionality to vim:
"Plugin 'tpope/vim-fugitive'
" Easy mappings to delete and change surroundings in pairs:
"Plugin 'tpope/vim-surround'
" Find files, and find them fast:
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Bright theme with pastel colors:
Plugin 'morhetz/gruvbox'
" Lean status/tabline for vim:
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Syntax highlighting for Javascript:
Plugin 'pangloss/vim-javascript'
" Syntax highlighting for C++:
Plugin 'octol/vim-cpp-enhanced-highlight'
" Syntax highlighting for Haskell:
Plugin 'neovimhaskell/haskell-vim'

" add plugins only above this line
call vundle#end()           " required

" Close vim if the only window left open is a NERDTree:
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" When Ctrl-t is pressed, toggle NERDTree:
noremap <C-t> :NERDTreeToggle<CR>

" fzf configuration
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
nnoremap <C-f> :FZF<cr>

" ALE config
"let g:ale_fixers = {
"\   '*': ['remove_trailing_lines', 'trim_whitespace'],
"\   'javascript': ['eslint'],
"\}

" Fixes the file everytime it is saved
"let g:ale_fix_on_save = 1
"let g:ale_completion_enabled = 1

"" coc.nvim config
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Integrate coc.nvim with Airline
let g:airline#exxtensions#coc#enabled = 1

" C++ highlighting configuration
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1
let c_no_curly_error=1

" Javascript highlighting configuration
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Haskell.vim config
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords



"" LOOK AND FEEL
" Make it so that Vim is always in dark mode
set background=dark

" I personally like the soft contrast, but you can change it to 'medium' or
" 'hard' if you want to do so
let g:gruvbox_contrast_dark = 'soft'
"let g:gruvbox_contrast_light = 'soft'
" Note: the line below always needs to come after all options of gruvbox you
" have added
colorscheme gruvbox

" Don't show current mode in plain text at the bottom of the page, as the
" statusline takes care of that
set noshowmode

" Let there be no visual delay when switching between modes
set ttimeoutlen=10

" I personally like the base16 airline theme. You could however find a list of
" all possible themes at https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_theme = 'base16'

" Makes it so that it does not draw separators for empty sections
let g:airline_skip_empty_sections = 1

" Show tabs at the top, even if there is just one buffer open
let g:airline#extensions#tabline#enabled = 1

" The following lines are for configuring the statusline. They can be set with
" the default statusline formatting, e.g. '%f' to display the path to the file
" relative to the current directory on the bar. See :help 'statusline'
"let g:airline_section_a = ''
"let g:airline_section_b = ''
"let g:airline_section_c = ''
let g:airline_section_x = '%Y'
"let g:airline_section_y = ''
"let g:airline_section_z = ''

" Cache the changes to the highlighting groups, should therefore be faster.
" Set this to one, if you experiene a sluggish Vim
let g:airline_highlighting_cache = 0

" If set to one, displays statusline in the tabline (first top line).
" If set to zero, displays the statusline at the bottom
let g:airline_statusline_ontop = 0

" Make airline use powerline fonts. This requires them to be installed on your
" machine, see: https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1

" By default, the tab bars at the top are going to have vertical borders. I
" like the separators to be angled, so I added the following lines, as is
" recommended by :help airline-configuration
" If there isn't a dictionary of symbols already, define it
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Add the following symbols to the dictionary:
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'



"" KEY BINDINGS
let mapleader = " "
inoremap <c-x> <Esc>ddi
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <C-s> :source $MYVIMRC<cr>

" Disable arrow keys
noremap <up> <NOP>
noremap <down> <NOP>
noremap <left> <NOP>
noremap <right> <NOP>
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>



"" ABBREVIATIONS
inoreab #i #include
inoreab #d #define



"" AUTOCOMMANDS
" Template
"augroup foo
"   autocmd!
"   autocmd foo
"augroup END
" You absolutely need to define autocomands in groups, otherwise Vim will
" double the amount of commands it executes every time you open it!
