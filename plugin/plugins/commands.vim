" -----------------
"  Custom Commands
" -----------------
" Butterfingers
command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Write     <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>

" Trim trailing whitespace
fun! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfun
command! StripWhitespace :call StripTrailingWhitespaces()

" Toggle showing whitespace characters
command! Tchars set list! list?

" Toggle tabs and spaces
command! Tspace set expandtab! expandtab?

" Toggle number and relative number with absolute position
command! Tnum set rnu!

" Toggle colorizer
command! Tcolor ColorizerToggle
