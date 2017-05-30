" Syntax highlighting
filetype plugin indent on
set background=dark
syntax enable

" Enable italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let g:wwdc16_term_italics = 1

" And true colours
set termguicolors
let &t_8f="\e[38;2;%lu;%lu;%lum"
let &t_8b="\e[48;2;%lu;%lu;%lum"

" WWDC 16 colour scheme
packadd! vim-wwdc16-theme
colorscheme wwdc16
set t_Co=256

" Basic options
set nowrap
set hlsearch
set number

" Tab completion
set wildmode=longest,list,full
set wildmenu

" Spellchecking
set spelllang="en_gb,cjk"

" Syntastic
packadd! syntastic

set statusline=%f\ %h%w%m%r\ 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=%(%l,%c%V\ %=\ %P%)

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" Tabs and spaces
set list
set listchars=tab:>-
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Tagbar
nmap \\ :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

let g:tagbar_show_linenumbers = 1
let g:tagbar_singleclick = 1
let g:tagbar_compact = 1

let g:tagbar_autopreview = 0
let g:tagbar_previewwin_pos = "topleft"
autocmd BufWinEnter * if &previewwindow | setlocal nonumber | endif

" NetRW
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = -80

" RSI
let g:rsi_no_meta = 1

" Easy alignment
xmap ga <Plug>(EasyAlign)

"""""""""""""""""""" BACKUP/UNDO/SWAP FILES """"""""""""""""""""
" This is taken from the following Stack Overflow post: http://stackoverflow.com/a/9528322

" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
if !has('nvim')
  set viminfo+=n~/.vim/viminfo
endif

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
"""""""""""""""""" END BACKUP/UNDO/SWAP FILES """"""""""""""""""

" Allow per-project .vimrc files
set exrc
set secure " Don't allow unsafe things from this point on (i.e. in per-project .vimrc files)
