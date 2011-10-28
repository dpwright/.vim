" GVim specific
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions-=e
set guioptions-=b
set guicursor=a:blinkon0

" Don't go into Japanese input mode automatically
" Automatically disable Japanese IME when leaving input mode
set iminsert=0
set imsearch=-1
inoremap <ESC> <ESC>:set iminsert=0<CR>

" Highlight cursor differently when in Japanese input mode
if has('multi_byte_ime')
	highlight Cursor guifg=NONE guibg=Green
	highlight CursorIM guifg=NONE guibg=Purple
endif

" Remap alt key combinations for working Windows alt key
map <silent> <m-h> :AV<cr>
imap <silent> <m-h> <esc>:AV<cr>
map <silent> <m-g> :IHT<cr>
imap <silent> <m-g> <esc>:IHT<cr>
map <m-q> :mksession! ~/.vim/.session<cr>
map <m-s> :source ~/.vim/.session<cr>

