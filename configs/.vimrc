syntax enable					  " enable syntax processing
set nocompatible
let g:python3_host_prog = '/usr/bin/python3'

" Vim Plugins ----------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

" Cosmetics
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
" File Search & Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
" Autocomplete, Tab, Snippets
Plug 'ervandew/supertab'
Plug 'ycm-core/YouCompleteMe'
Plug 'sirver/ultisnips'
" LANGUAGES
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sebdah/vim-delve'
" YAML
Plug 'tarekbecker/vim-yaml-formatter'

call plug#end()

" Theme/Color ----------------------------------------------------------------
set termguicolors                 " use true colors

" onedark colorscheme
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1
colorscheme onedark

" Tabs and Spacing -----------------------------------------------------------
set tabstop=4      " visual spaces per tab
set softtabstop=4  " number of spaces in tab when editing
set shiftwidth=4   " number of spaces from reindent ops (<<, >>)
set expandtab      " tabs are spaces
let g:yaml_formatter_indent_collection=1

" UI Config ------------------------------------------------------------------
set number         " show line numbers
set showcmd        " show command in bottom bar
set cursorline     " highlight current line
filetype indent on " load filetype-specific indent files
filetype plugin on " enable filetype plugins
set wildmenu       " visual autocomplete for command menu
set lazyredraw     " redraw only when we need to
set showmatch      " highlight matching [{()}]
set signcolumn=yes " Always show sign column
set clipboard=unnamedplus " Use system clipboard
"set spell          " Spellcheck
set splitright
set splitbelow

set breakindent                " enable word wrap indentation
set showbreak=>>               " print >> on word wrapped lines
set breakindentopt=shift:2,sbr " shift word wrap in by 2 characters
							   " and print showbreak at beginning of line

" These settings are irrelevant as long as we are using NerdTree, but I'll keep
" them anyway
let g:netrw_liststyle = 3    " default to verbose explorer view
let g:netrw_banner = 0       " remove explorer banner
let g:netrw_browse_split = 2 " open files in new vertical split
let g:netrw_winsize = 10     " explorer takes 25% of window

" vertical help window
cnoreabbrev H vert h 

" NERDTree -------------------------------------------------------------------
let NERDTreeMapJumpNextSibling = ',j' " because I later use <C-J> I remap this
let NERDTreeMapJumpPrevSibling = ',k' " because I later use <C-K> I remap this

let NERDTreeShowHidden = 1 " show hidden files by default

let NERDTreeWinPos = 'left' " open NERDTree on leftside always
let NERDTreeMinimalMenu = 1 " use minimal menu
let NERDTreeMinimalUI = 1 " hide ?
let NERDTreeDirArrows = 1 " hide nav instructions

let NERDTreeAutoDeleteBuffer = 1 " close buffers for files who are deleted or
                                 " renamed'

" start NERDTree on 'nv'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Terminal -------------------------------------------------------------------
tnoremap <Esc> <C-\><C-n>

" Searching ------------------------------------------------------------------
set incsearch " search as characters are entered
set hlsearch " highlight matches
set path+=** " recursively search for anything

set rtp+=~/.fzf " set fzf runtime directory

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Movement -------------------------------------------------------------------
" move vertically by visual line
noremap j gj
noremap k gk

" swap record and back-word keys
" I do this because lining up QWE for navigating words makes sense to me, and I
" always miss the b key. I also do not use the record function very often
noremap q b
noremap b q

" move to the beginning/end of a line
" this will overwrite two existing movement hotkeys
noremap Q ^
noremap E $

" $/^ won't do anything
noremap $ <nop>
noremap ^ <nop>

set textwidth=80 " set reflow max line width to 79

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

" ,f launches fuzzy file finder in cwd
nnoremap <leader>f :FZF<CR>
let g:fzf_action = { 'enter': 'vsplit' } " open files in vert split

" ,F launches fuzzy file finder in home dir
nnoremap <leader>F :FZF ~<CR>

" ,g launches ag in cwd
nnoremap <leader>g :Ag<CR>

" ,G launches ag in home dir
nnoremap <leader>G :Ag ~<CR>

" ,d toggles the NERDTree explorer
nnoremap <leader>d :NERDTreeToggle<CR>

" ,cd sets the global current directory to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" ,wcd sets the window current directory to the current file
nnoremap <leader>wcd :lcd %:p:h<CR>:pwd<CR>

" Notes ---------------------------------------------------------------------
" Auto-create parent directories if they don't exist on save
function s:MkNonExDir(file)
    if a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'))
    autocmd FileWritePre * :call s:MkNonExDir(expand('<afile>'))
augroup END

nnoremap <leader>n :FZF ~/notes<CR>

vnoremap <leader>s :w ~/notes/
nnoremap <leader>s :w ~/notes/

" ==================== Languages ====================
" Proto ----------------------------------------------------------------------
au FileType proto set expandtab
au FileType proto set shiftwidth=4
au FileType proto set softtabstop=4
au FileType proto set tabstop=4

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

" terminal
let g:go_term_enabled = 1
let g:go_term_mode = "split"
let g:go_term_height = 13

" This is great to see the output of GoRun or if you're printing debug lines in
" a GoTest but is otherwise annoying
let g:go_term_close_on_exit = 0

" similar variable highlighting
let g:go_auto_sameids = 1

" auto-import dependencies
let g:go_fmt_command = "goimports"

" run unit tests
au FileType go nmap <F9> :GoCoverageToggle -short<CR>

" show type information in status line
let g:go_auto_type_info = 1

" JSON stsruct tagging uses snake case
let g:go_addtags_transform = "snakecase"

" Dlv Settings
" let g:delve_backend = "native"

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient
let g:go_def_mapping_enabled = 0

" use gopls
let g:go_def_mode = "gopls"

" <Leader>g opens GoDef in new tab
autocmd FileType go nmap <silent> <Leader>g <Plug>(go-def-tab)

" extend default test timeout value
let g:go_test_timeout = '30s'

" ==================== Completion + Snippet ====================
" Remap YouCompleteMe navigation keys to <C-n>
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Snippets expand on Tab
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

" Error and warning signs -----------------------------------------------------
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
