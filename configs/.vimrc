syntax enable					  " enable syntax processing
let g:python3_host_prog = '/usr/bin/python3.7'

" Vim Plugins ----------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
Plug '~/.fzf'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'
Plug 'dense-analysis/ale'
Plug 'sebdah/vim-delve'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
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
set signcolumn=yes " Always show sign column
set clipboard=unnamedplus " Use system clipboard

set breakindent                " enable word wrap indentation
set showbreak=>>               " print >> on word wrapped lines
set breakindentopt=shift:2,sbr " shift word wrap in by 2 characters
							   " and print showbreak at beginning of line
let g:netrw_liststyle = 3    " default to verbose explorer view
let g:netrw_banner = 0       " remove explorer banner
let g:netrw_browse_split = 2 " open files in new vertical split
let g:netrw_winsize = 10     " explorer takes 25% of window

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
au FileType go inoremap xnewtest <esc>:r ~/.vim/snippets/go/newtest.go<CR>wcw
au FileType go inoremap xtesttop <esc>:r ~/.vim/snippets/go/testtop.go<CR>a
au FileType go inoremap xasserteq <esc>:r ~/.vim/snippets/go/asserteq.go<CR>a
au FileType go inoremap xassertn <esc>:r ~/.vim/snippets/go/assertn.go<CR>a
au FileType go inoremap xassertnn <esc>:r ~/.vim/snippets/go/assertnn.go<CR>a

" JSON stsruct tagging uses snake case
let g:go_addtags_transform = "snakecase"

" Dlv Settings
let g:delve_backend = "native"

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient
let g:go_def_mapping_enabled = 0

" use gopls
let g:go_def_mode = "gopls"

" Conqueror of Completion Settings --------------------------------------------
" " Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" " use <tab> and <S-tab> to navigate completion list
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" 
" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()
" 
" " Use `[c` and `]c` to navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)
" 
" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" 
" " Use U to show documentation in preview window
" nnoremap <silent> U :call <SID>show_documentation()<CR>
" 
" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
" 
" " Remap for format selected region
" " vmap <leader>f  <Plug>(coc-format-selected)
" " nmap <leader>f  <Plug>(coc-format-selected)
" "
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" let g:neosnippet#snippets_directory='~/.vim/snippets'

" Deoplete --------------------------------------------------------------------
" Use deoplete.
" let g:deoplete#enable_at_startup = 1

" set completeopt-=preview " remove the preview window

" <TAB> completion
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ==================== Completion + Snippet ====================
" Ultisnips has native support for SuperTab. SuperTab does omnicompletion by
" pressing tab. I like this better than autocompletion, but it's still fast.
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"  
let g:UltiSnipsJumpBackwardTrigger="<s-tab>" 

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" Error and warning signs -----------------------------------------------------
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
