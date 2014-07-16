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
set ts=3                       " A tab is three spaces
set sw=3                       " Autoindent tab is three spaces
set tw=80                      " Column width 80 characters
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set autoindent                 " Always set autoindenting on
set copyindent                 " Copy the previous indentation on autoindenting
set number                     " Always show line numbers
set ruler                      " Show line and column number in status bar
set ls=2                       " Always show status bar
set cursorline                 " Highlight the current line
set modeline                   " Enable modeline settings
set modelines=1                " Need to set this > 0

" Mouse support (https://wincent.com/blog/tweaking-command-t-and-vim-for-use-in-the-terminal-and-tmux)
if has('mouse')
  set mouse=nicr "Don't enter visual mode automatically
  if &term =~ "xterm" || &term =~ "screen"
    " for some reason, doing this directly with 'set ttymouse=xterm2'
    " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
    " makes tmux enter copy mode instead of selecting or scrolling
    " inside Vim -- but luckily, setting it up from within autocmds
    " works
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  endif
endif

" Folds
set foldmethod=syntax
set foldlevel=20               " Default to have all folds open

" Change the mapleader from \ to ,
let mapleader=","
let g:mapleader=","

" Show tabs
set list
set listchars=tab:>-

" Highlight end of line whitespace non-obnoxiously
" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

" Tab expansion
set wildmode=longest,list

" Fancy searching
set hlsearch
set incsearch

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
" (Temporarily disabled)
"set grepprg=ack-grep\ --column
"set grepformat=%f:%l:%c:%m

" I want to use a login shell so I get all my .profile settings in :shell
if has("win32")
  set shell=cmd.exe
  set shellcmdflag=/C
else
  set shell=zsh
endif

" Set tags files
set tags+=./tags
set tags+=~/.tags/cpp.tags

" Generate and set local tags file
command GenerateTags :silent execute "!ctags -R --fields=+l . &" | redraw!
command GenerateCPPTags :silent execute "!ctags --c-kinds=+p --c++-kinds=+p --fields=+iaSl --extra=+q --language-force=C++ -R . &" | redraw!
command GenerateSourceTags :silent execute "!ctags --c-kinds=+p --c++-kinds=+p --fields=+iaSl --extra=+q --language-force=C++ -R source/ &" | redraw!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Language settings (Spoken)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932
"set ambiwidth=double            "~/.Xresources should have XTerm*cjkWidth: true
set ambiwidth=single            "Better for greek letters...
let $LANG='ja'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Syntax / Colour settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on syntax highlighting and filetype detection
syntax on
hi Todo cterm=BOLD ctermbg=red ctermfg=white

" Mark textwidth-defined column
" Only for code (and when not diffing)
if &diff
else
au FileType c,cpp,ruby,pawn,haskell,lhaskell exec 'set colorcolumn=' . &textwidth
endif

" Theme settings -- is setting t_Co in here a good idea?
set background=dark

let g:solarized_italic = 0
let g:solarized_termtrans = 1
let g:solarized_termcolors=16
set t_Co=256
let g:rehash256=1
colorscheme molokai
hi link ColorColumn CursorLine

" Rainbow parentheses
let g:rbpt_max = 30
let g:rbpt_colorpairs = [
               \ ['White',       'White'],
               \ ['Cyan',        'Cyan'],
               \ ['Red',         'Red'],
               \ ['DarkBlue',    'DarkBlue'],
               \ ['DarkMagenta', 'DarkMagenta'],
               \ ['DarkYellow',  'DarkYellow'],
               \ ['Magenta',     'Magenta'],
               \ ['DarkGreen',   'DarkGreen'],
               \ ['DarkCyan',    'DarkCyan'],
               \ ['DarkRed',     'DarkRed'],
               \ ]

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Markdown
let g:markdown_fenced_languages = ['haskell', 'lisp', 'scheme', 'ruby']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Language settings (programming)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Some C Shortcuts
ab #d #define
ab #i #include
ab #e #endif

" Erlang manpage directory
let g:erlang_man_path='/usr/local/share/man'

" VimClojure settings
let g:vimclojure#ParenRainbow = 0
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#DynamicHighlighting = 1

let g:clojure_align_multiline_strings = 1

" Haskell
let g:hpaste_author = "dpwright"

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
"let Tlist_Ctags_Cmd = 'ctags --extra=-q --c++-kinds=-p'
"map <F3> :TlistToggle<CR>

" Tagbars
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
map <F3> :TagbarToggle<CR>

" Gundo
map <F4> :GundoToggle<CR>

" Yankring
let g:yankring_history_dir='~/.vim/'

" Airline
if !has("win32")
  let g:airline_powerline_fonts = 1
endif

" EasyTags
let g:easytags_dynamic_files = 1
let g:easytags_resolve_links=1
let g:easytags_include_members=1
let g:easytags_on_cursorhold=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Leader keymappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t :tabe 
map <leader>c :GenerateSourceTags<cr>

" Quicklist helpers
map <leader>cc :botright cope<cr>

" Ctrl-P
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
                        \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|obj|romfiles)$',
  \ 'file': '\v\.(exe|so|dll|axf|amx)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }
let g:ctrlp_map = '<c-p>'
nnoremap <silent> <Leader>f :CtrlP<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-lldb mappings
"" Convention: "do*", where * is specific to the operation.
"" Mnemonic: "Debugger Operation"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lldb_map_Lbreakpoint = "dob"
let g:lldb_map_Lstep       = "doi"
let g:lldb_map_Lfinish     = "doo"
let g:lldb_map_Lnext       = "do\ "
let g:lldb_map_Lcontinue   = "doc"
let g:lldb_map_Lup         = "doj"
let g:lldb_map_Ldown       = "dok"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-slime
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

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
function! s:MakeAndSetSession()
	let sessionfile = ".session.vim"
	exe "mksession! ".sessionfile
	au VimLeave * :exe "mksession! ".sessionfile
endfunction

function! s:SourceAndSetSession()
	let sessionfile = ".session.vim"
	if(filereadable(sessionfile))
		exe "source ".sessionfile
	endif
	au VimLeave * :exe "mksession! ".sessionfile
endfunction

map <silent> <leader>w :call <SID>MakeAndSetSession()<cr>
map <silent> <leader>q :call <SID>SourceAndSetSession()<cr>

" F5 inserts today's date
nnoremap <F5> "=strftime("%Y/%m/%d (%a)")<CR>Pa<CR><esc>
inoremap <F5> <C-R>=strftime("%Y/%m/%d (%a)")<CR><CR>

" Easy grepping of word under cursor (ctrl+alt+])
nmap <esc><c-]> :grep -r "<cword>" 
imap <esc><c-]> <esc>:grep -r "<cword>" 
vnoremap <esc><c-]> :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy:<C-U>grep -r "<C-R><C-R>=
  \escape(@", '\.*$^~[')<CR>" 

" Search within file
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Set .p and .inc files to use the sourcepawn filetype
" (a modified version of standard pawn for which there is a vim plugin)
let filetype_p = "sourcepawn"
let filetype_inc = "sourcepawn"

" Support visual-studio style error output
set errorformat+=\ %#%f(%l\\\,%c):\ %m

" Custom statusline -- makes use of taglist
" Disabled for now as it was annoying me
" set statusline=%<%f:\ %{Tlist_Get_Tag_Prototype_By_Line()}%h%m%r\ %=%-7.(%l,%c%V%)\ %P

" Another custom statusline -- this one uses fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Cool little svn blame snippet -- gl to blame a range of lines.  From here:
" http://tammersaleh.com/posts/quick-vim-svn-blame-snippet
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Open a shell command in a scratch buffer. From
" http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
	let isfirst = 1
	let words = []
	for word in split(a:cmdline)
		if isfirst
			let isfirst = 0  " don't change first word (shell command)
		else
			if word[0] =~ '\v[%#<]'
				let word = expand(word)
			endif
			let word = shellescape(word, 1)
		endif
		call add(words, word)
	endfor
	let expanded_cmdline = join(words)
	belowright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	call setline(1, 'You entered:  ' . a:cmdline)
	call setline(2, 'Expanded to:  ' . expanded_cmdline)
	call append(line('$'), substitute(getline(2), '.', '=', 'g'))
	silent execute '$read !'. expanded_cmdline
	1
endfunction

" Support the Man command to look up manpages within vim (like vim help)
runtime ftplugin/man.vim
let PAGER=''

" Journal settings
let g:journal_encrypted=1
let g:journal_directory="~/.journal"
let g:GPGDefaultRecipients="dani@dpwright.com"

" View .docx (MS Word) documents in vim
"autocmd BufReadPre *.docx set ro
"autocmd BufReadPost *.docx %!docx2txt.pl
