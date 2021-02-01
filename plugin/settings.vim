" -------------------------
"  General neovim settings
" -------------------------
" Faster updatetime
set updatetime=200

" -- Display --
" Numbers in the gutter
set number

" Break lines at word
set linebreak

" Wrap-broken line prefix
let &showbreak = "⤚ "

" Highlight matching brace
set showmatch

" Highlight yanked text
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank {higroup="IncSearch", timeout=200}
augroup END

" Visual bell
set visualbell

" Whitespace characters
set listchars=tab:├─,space:·

" Sane splits
set splitright
set splitbelow

" Set theme
syntax on
set termguicolors
colorscheme koda

" Sign Column
set signcolumn=yes:1

" Show one line above the cursor
set scrolloff=1

" Show one column left/right of the cursor
set sidescrolloff=1

" -- Find and Replace --
" Highlight search
set hlsearch

" Enable smart-case search
set smartcase

" Case insensitive search
set ignorecase

" Search incrementally
set incsearch

" -- Indentation --
" Spaces instead of tab
set softtabstop=4
set shiftwidth=4
set expandtab

" -- Diff --
set diffopt=vertical,filler,foldcolumn:1,indent-heuristic,algorithm:patience
if &diff
    syntax off
    setlocal nospell
endif

" -- Miscellaneous --
" Mouse support
set mouse=a

" Row and column ruler
set ruler

" Lazy redraw
set lazyredraw

" Nomodeset
set nomodeline

" Don't show mode
set noshowmode

" Dictionary
set dictionary+=/usr/share/dict/words

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing extra message when using completion
set shortmess+=c

" Live substitution
set inccommand=nosplit

" Persistent undo
set undofile

" Backups
set backup
set backupdir=/tmp//

" Insert only one space using `join`
set nojoinspaces

" Indent wrap lines the same as previous
set breakindent

" Cursor go vroom
set virtualedit=block

" Python
let g:python_host_prog = '/home/kosa/Documents/code/python/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/kosa/Documents/code/python/.pyenv/versions/neovim3/bin/python'

" Lua
lua require('lsp')
