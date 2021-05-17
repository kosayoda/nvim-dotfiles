" ----------
"  init.vim
" ----------
call plug#begin('~/.local/share/nvim/plugged')

" - Development -
" LSP lightbulb
Plug '~/Documents/code/lua/nvim-lightbulb'
" Theme
Plug '~/Documents/koda/koda-vim'

" - Visual plugins -
" Status line
Plug 'rbong/vim-crystalline'
" Start screen
Plug 'mhinz/vim-startify'
" Highlighter
Plug 'norcalli/nvim-colorizer.lua'

" - General -
" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
" Horizontal movement highlighting
Plug 'unblevable/quick-scope'
" Smooth scrolling
Plug 'karb94/neoscroll.nvim'
" Edit surroundings of text objects
Plug 'machakann/vim-sandwich'
" Automatically change directory to project root
Plug 'airblade/vim-rooter'
" Indentation guides
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
" vim-repeat
Plug 'tpope/vim-repeat'

" -- Coding and language specific --
" - LSP -
" Neovim LSP
Plug 'neovim/nvim-lspconfig'
" LSP completion
Plug 'hrsh7th/nvim-compe'
" LSP status
Plug 'nvim-lua/lsp-status.nvim'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" - Git -
" Commit messages
Plug 'rhysd/committia.vim'
" Git messenger
Plug 'rhysd/git-messenger.vim'
" Git signs
Plug 'lewis6991/gitsigns.nvim'

" - Language-specific -
" LaTeX
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
" Python
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
" Markdown
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'}

call plug#end()
