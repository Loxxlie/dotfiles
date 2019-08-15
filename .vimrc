" Theme/Color ----------------------------------------------------------------
syntax enable					  " enable syntax processing
set background=dark               " use dark background for solarized8
set termguicolors                 " use true colors
colorscheme solarized8            " set colorscheme
let g:airline_theme='solarized'   " set airline theme
let g:airline_solarized_bg='dark' " set airline theme solarized to dark

" Tabs and Spacing -----------------------------------------------------------
set tabstop=4      " visual spaces per tab
set softtabstop=4  " number of spaces in tab when editing
set shiftwidth=4   " number of spaces from reindent ops (<<, >>)
set expandtab      " tabs are spaces

" UI Config ------------------------------------------------------------------
set number         " show line numbers
set showcmd        " show command in bottom bar
set cursorline     " highlight current line
filetype indent on " load filetype-specific indent files
set wildmenu       " visual autocomplete for command menu
set lazyredraw     " redraw only when we need to
set showmatch      " highlight matching [{()}]

let g:netrw_liststyle = 3    " default to verbose explorer view
let g:netrw_banner = 0       " remove explorer banner
let g:netrw_browse_split = 4 " open files in previous window
let g:netrw_winsize = 25     " explorer takes 25% of window

" this is supposed to fix closing netrw buffers
autocmd FileType netrw setl bufhidden=delete

" Searching ------------------------------------------------------------------
set incsearch " search as characters are entered
set hlsearch " highlight matches

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Movement -------------------------------------------------------------------
" move vertically by visual line
noremap j gj
noremap k gk

" move to the beginning/end of a line
" this wil overwrite two existing movement hotkeys
noremap B ^
noremap E $

" $/^ won't do anything
noremap $ <nop>
noremap ^ <nop>

" Tab/Window Navigation ------------------------------------------------------
" the following make it easy to navigate around windows
nnoremap g<Right> <C-w><Right>
nnoremap g<Left> <C-w><Left>
nnoremap g<Up> <C-w><Up>
nnoremap g<Down> <C-w><Down>

" the following makes it easy to open and close windows
nnoremap gs :vnew<CR>
nnoremap gS <C-w>q

" Leader/Misc Shortcuts ------------------------------------------------------
let mapleader=","   " leader is comma

" jk is escape
inoremap jk <esc>

" ,f launches fuzzy file finder in cwd
nnoremap <leader>f :FZF<CR>

" ,F launches fuzzy file finder in home dir
nnoremap <leader>F :FZF<CR>

" Vim-Go Settings ------------------------------------------------------------
" Go indentation settings
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" Go color highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" similar variable highlighting
let g:go_auto_sameids = 1

" auto-import dependencies
let g:go_fmt_command = "goimports"

