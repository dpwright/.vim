" Stuff that needs to be called right at the start
" Remove vi backwards compatibility & set up pathogen
" This filetype toggling is for compatibility with mac & debian;
" see http://andrewho.co.uk/weblog/vim-pathogen-with-mutt-and-git
filetype on
filetype off
set nocompatible
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap                     " Don't wrap lines
set ts=4                       " A tab is four spaces
set sw=4                       " Autoindent tab is four spaces
set tw=100                     " Column width 100 characters
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set autoindent                 " Always set autoindenting on
set copyindent                 " Copy the previous indentation on autoindenting
set number                     " Always show line numbers
set ruler                      " Show line and column number in status bar
set mouse=a                    " Mouse control in terminal

" Folds
set foldmethod=syntax
set foldlevel=20               " Default to have all folds open

" Change the mapleader from \ to ,
let mapleader=","
let g:mapleader=","

" Show tabs
set list
set listchars=tab:>-

" Tab expansion
set wildmode=longest,list

" Fancy searching
set hlsearch
set incsearch

" Check file modified on cursor move
au CursorHold * checktime
au FocusGained * checktime

" Disable vim backup
set nobackup
set noswapfile

" Big history
set history=1000
set undolevels=1000

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" I use ack (http://betterthangrep.com/)
set grepprg=ack-grep\ --column
set grepformat=%f:%l:%c:%m

" I want to use a login shell so I get all my .profile settings in :shell
set shell=bash\ --login

" Set tags files
set tags+=~/.tags/cpp.tags

" Generate and set local tags file
command GenerateTags :silent execute "!exctags -R . &" | redraw!
command GenerateCPPTags :silent execute "!exctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -R . &" | redraw!
command GenerateSourceTags :silent execute "!exctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -R source/ &" | redraw!
set tags+=./tags

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Language settings (Spoken)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932
set ambiwidth=double            "~/.Xresources should have XTerm*cjkWidth: true
let $LANG='ja'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Syntax / Colour settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on syntax highlighting and filetype detection
syntax on
hi Todo cterm=BOLD ctermbg=red ctermfg=white

" Mark after 100th column
au BufEnter * exec 'match Todo /\%>' . &textwidth . 'v.\+/'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Language settings (programming)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Some C Shortcuts
ab #d #define
ab #i #include
ab #e #endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Plugin specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" a.vim -- Switch between header and footer
map <silent> h :AV<cr>
imap <silent> h <esc>:AV<cr>
map <silent> g :IHT<cr>
imap <silent> g <esc>:IHT<cr>

" OmniCPPComplete -- Autocomplete options
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0

" NERD Tree
map <F2> :NERDTreeToggle<CR>
let NERDMouseMode = 2
let NERDMinimalUI = 1
let NERDTreeQuitOnOpen = 1

" Taglist
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Process_File_Always = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Enable_Fold_Column = 0
let Tlist_Display_Prototype = 0
let Tlist_Use_Right_Window = 1
let Tlist_Close_On_Select = 1
let Tlist_Compact_Format = 1
let Tlist_Show_One_File = 1
let Tlist_Ctags_Cmd = 'exctags --extra=-q --c++-kinds=-p'
map <F3> :TlistToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Leader keymappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t :tabe 
map <leader>c :GenerateSourceTags<cr>

" Quicklist helpers
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" Command-T
nmap <silent> <Leader>f :CommandT<CR>
nmap <silent> <Leader>b :CommandTBuffer<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Miscellaneous
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Code mask -- Sometimes I want to take screenshots of my vim layout but the
"              code I'm working on may be sensitive.  Running this command
"              masks it.
command CodeMask :%s/\(\a\|\d\)/#/g

" Session shortcuts -- I use this to save and restore a complete session
"                      including all tabs that may be open
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
map q :mksession! ~/.vim/.session<cr>
map s  :source ~/.vim/.session<cr>

" F5 inserts today's date
nnoremap <F5> "=strftime("%Y/%m/%d (%a)")<CR>Pa<CR><esc>
inoremap <F5> <C-R>=strftime("%Y/%m/%d (%a)")<CR><CR>

" Easy grepping of word under cursor (ctrl+alt+])
nmap <esc><c-]> :grep -r "<cword>" *<cr>
imap <esc><c-]> <esc>:grep -r "<cword>" *<cr>
vnoremap <esc><c-]> :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy:<C-U>grep -r "<C-R><C-R>=
  \escape(@", '\.*$^~[')<CR>" *<CR>

" Search within file
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" I work with a scripting language called pawn a lot.
" I've copied the C syntax file into syntax/pawn for this purpose
let filetype_p = "pawn"

" Custom statusline -- makes use of taglist
" Disabled for now as it was annoying me
" set statusline=%<%f:\ %{Tlist_Get_Tag_Prototype_By_Line()}%h%m%r\ %=%-7.(%l,%c%V%)\ %P

" FreeBSD security recommends removing modeline support to avoid trojans
