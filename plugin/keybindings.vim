" -------------
"  Keybindings
" -------------
" Map the leader key to SPACE
let mapleader="\<Space>"
let maplocalleader="\\"
nnoremap <Space> <nop>

" -- Search --
" Search and Replace
noremap <leader>r :s//g<Left><Left>
" File-wide Search and Replace
noremap <leader>R :%s//g<Left><Left>
" Center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" -- Pasting --
" Yank into + buffer
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>Y "+Y
vmap <leader>Y "+Y
" Paste from + buffer
nmap <leader>p "+p
vmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>P "+P

" -- Jumping --
" Center jump results
nnoremap <silent> ]c ]czz
nnoremap <silent> [c [czz

" -- All Modes --
" Remove highlight on escape
map <silent> <ESC> :<C-u>nohlsearch<cr>

" Show syntax highlighting groups
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Make yank the same as delete and change
map Y y$

" -- Normal Mode --
" Move by line, useful for editing wrapped lines
nnoremap j gj
nnoremap k gk
" Quick save
nmap <silent> <leader>w :w<CR>
" Prevent accidentally entering ex mode
nnoremap Q <Nop>
" Backspace switches to last used file
nnoremap <BS> <C-^>

" If split in given direction exists - jump, else create new split
function! JumpOrOpenNewSplit(key, cmd)
  let current_window = winnr()
  execute 'wincmd' a:key
  if current_window == winnr()
    execute a:cmd
  endif
endfunction
nnoremap <silent> <M-h> :call JumpOrOpenNewSplit('h', ':leftabove vsplit')<CR>
nnoremap <silent> <M-l> :call JumpOrOpenNewSplit('l', ':rightbelow vsplit')<CR>
nnoremap <silent> <M-k> :call JumpOrOpenNewSplit('k', ':leftabove split')<CR>
nnoremap <silent> <M-j> :call JumpOrOpenNewSplit('j', ':rightbelow split')<CR>

" Move the current line up or down (takes a count too!)
nnoremap <silent> <Plug>MoveLineUp :<C-u>execute 'move -1-'.. v:count1<CR>
      \ :call repeat#set("\<Plug>MoveLineUp", v:count)<CR>h
nmap <C-p> <Plug>MoveLineUp
nnoremap <silent> <Plug>MoveLineDown :<C-u>execute 'move +'. v:count1<CR>
      \ :call repeat#set("\<Plug>MoveLineDown", v:count)<CR>h
nmap <C-n> <Plug>MoveLineDown

" Add empty lines above or below
nnoremap <silent> <Plug>AddEmptyLinesAbove :<C-u>put! =repeat(nr2char(10), v:count)<cr>
      \ :call repeat#set("\<Plug>AddEmptyLinesAbove", v:count)<CR>k
nmap <leader>k <Plug>AddEmptyLinesAbove
nnoremap <silent> <Plug>AddEmptyLinesBelow :put =repeat(nr2char(10), v:count)<CR>
      \ :call repeat#set("\<Plug>AddEmptyLinesBelow", v:count)<CR>k
nmap <leader>j <Plug>AddEmptyLinesBelow

" -- Visual Mode --
" Sort selected lines
vnoremap gs :sort<CR>
vnoremap gS :!sort<CR>
" When indenting/dedenting with visual mode, keep selection
xnoremap > >gv
xnoremap < <gv
" In visual mode, tab/shift-tab to indent/dedent visually selected blocks
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
