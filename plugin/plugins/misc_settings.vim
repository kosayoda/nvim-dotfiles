" == Vimscript plugins ==
" -- quick-scope --
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars = 10000

" == Lua plugins ==
" -- Indent blankline --
let g:indent_blankline_char = '│'
let g:indent_blankline_space_char = ' '
let g:indent_blankline_filetype = [
    \ "vim", "lua", "python", "rust", "html", "css", "javascript", "typescript", "svelte"
    \ ]

let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_first_indent_level = v:false

" -- Telescope --
nnoremap <silent> <Leader>o :lua require("_telescope").find_files()<CR>
nnoremap <silent> <Leader>/ :lua require("_telescope").live_grep()<CR>
nnoremap <silent> <Leader><Enter> :lua require("_telescope").buffers()<CR>
nnoremap <silent> <Leader>ss :lua require("_telescope").spell_suggest()<CR>
