syntax enable					  " enable syntax processing

" Vim Plugins ----------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
Plug '~/.fzf'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'
Plug 'dense-analysis/ale'
call plug#end()

" Theme/Color ----------------------------------------------------------------
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

set breakindent                " enable word wrap indentation
set showbreak=>>               " print >> on word wrapped lines
set breakindentopt=shift:2,sbr " shift word wrap in by 2 characters
							   " and print showbreak at beginning of line
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

" map reflow to Q, overwriting :Ex mode shortcut
nnoremap Q gq
set textwidth=79 " set reflow max line width to 79

" Tab/Window Navigation ------------------------------------------------------
" the following make it easy to navigate around windows
noremap <C-l> <C-w><Right>
noremap <C-h> <C-w><Left>
noremap <C-k> <C-w><Up>
noremap <C-j> <C-w><Down>

" the following makes it easy to open and close windows
nnoremap gS :vnew<CR>
nnoremap gs <C-w>q

" Leader/Misc Shortcuts ------------------------------------------------------
let mapleader=","   " leader is comma

" jk is escape
inoremap jk <esc>

" ,f launches fuzzy file finder in cwd
nnoremap <leader>f :FZF<CR>

" ,F launches fuzzy file finder in home dir
nnoremap <leader>F :FZF ~<CR>

" ,cd sets the global current directory to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" ,wcd sets the window current directory to the current file
nnoremap <leader>wcd :lcd %:p:h<CR>:pwd<CR>

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

" run unit tests
au FileType go nmap <F9> :GoCoverageToggle -short<CR>

" show type information in status line
let g:go_auto_type_info = 1

" Go Macros
au FileType go noremap xnewtest :r ~/.vim/snippets/go/newtest.go<CR>
au FileType go noremap xtesttop :r ~/.vim/snippets/go/testtop.go<CR>
au FileType go noremap xasserteq :r ~/.vim/snippets/go/asserteq.go<CR>
au FileType go noremap xassertn :r ~/.vim/snippets/go/assertn.go<CR>
au FileType go noremap xassertnn :r ~/.vim/snippets/go/assertnn.go<CR>

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
