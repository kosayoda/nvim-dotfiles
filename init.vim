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
Plug 'psliwka/vim-smoothie'
" Edit surroundings of text objects
Plug 'machakann/vim-sandwich'
" View register contents
Plug 'junegunn/vim-peekaboo'
" Align text
Plug 'junegunn/vim-easy-align'
" Automatically change directory to project root
Plug 'airblade/vim-rooter'
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
" LSP extensions (inlay hints mainly)
Plug 'nvim-lua/lsp_extensions.nvim'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" - Git -
" Commit messages
Plug 'rhysd/committia.vim'
" Git messenger
Plug 'rhysd/git-messenger.vim'
Plug 'rhysd/conflict-marker.vim'

" - Language-specific -
" LaTeX
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
" Python
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
" Svelte
Plug 'leafOfTree/vim-svelte-plugin'
" Markdown
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'}

call plug#end()
