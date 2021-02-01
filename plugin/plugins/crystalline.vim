" --------------------------
"  vim-crystalline Settings
" --------------------------
let g:crystalline_mode_labels = {
    \ 'n': ' N ',
    \ 'v': ' V ',
    \ 'i': ' I ',
    \ 'R': ' R ',
    \ }

" LSP diagnostics
function! Diagnostics() abort
	if luaeval('#vim.lsp.buf_get_clients() > 0')
	    return luaeval("require('status').status()")
    endif
	return ''
endfunction

" Statusline function
function! StatusLine(current, width)
    let status = a:current ?
        \ crystalline#mode_color() . " %{&ft != '' ? &ft : '-'} "
        \ . '%#Crystalline#' : '%#CrystallineInactive#'

    let cursor_position = a:current ?
        \ a:width > 80 ? ' %#CrystallineVisualMode# C: %c %#CrystallineInsertMode# L: %l/%L ' : ' '
        \ : ''

    return status
        \ . (a:width > 50 ? ' %f' : ' %t')
        \ . ' %= '
        \ . Diagnostics()
        \ . cursor_position
endfunction

" Update statusline
function! s:crystalline_update() abort
    let g:crystalline_statusline_fn = 'StatusLine'
endfunction

" Tabline function
function! TabLine()
  let vimlabel = has("nvim") ?  " NVIM " : " VIM "
  return crystalline#bufferline(3, 10, 0)
        \ . '%='
        \ . '%#CrystallineTab#%( %m%h%r %)'
        \ . '%#CrystallineInsertMode# ' . "%{empty(&fenc) ? &enc : &fenc} | %{&ff} "
        \ . '%#CrystallineTabType#' . vimlabel
endfunction

" Settings
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_tab_mod = ' '
let g:crystalline_theme = 'koda'

" Always show tabline and statusline
set showtabline=2
set laststatus=2
