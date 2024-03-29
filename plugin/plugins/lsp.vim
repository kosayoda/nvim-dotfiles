" -- nvim-compe --
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <CR> compe#confirm('<CR>')

" Deprecated in favour of the lua configuration
" inoremap <silent><expr> <Tab>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<Tab>" :
"   \ compe#complete()
" inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

augroup HighlightOverride
  autocmd!
  au ColorScheme * highlight LightBulbVirtualText guifg=#e0af68
augroup END
