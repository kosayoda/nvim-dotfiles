" ----------
"  init.vim
" ----------
call plug#begin('~/.local/share/nvim/plugged')

" - Development -
" Neovim LSP
Plug 'neovim/nvim-lspconfig'

" LSP lightbulb
Plug '~/Documents/code/lua/nvim-lightbulb'

call plug#end()


set number
set signcolumn=yes:1
set updatetime=200

lua << EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(_)
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    local mapper = function(mode, key, result)
        vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
    end

    -- Information and search
    mapper('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>')
    mapper('n', 'gd',        '<cmd>lua vim.lsp.buf.declaration()<CR>')
    mapper('n', 'gD',        '<cmd>lua vim.lsp.buf.definition()<CR>')
    -- mapper('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>')
    -- mapper('n', 'gt',        '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- mapper('n', 'gW',        telescope('lsp_workspace_symbols'))

    -- Actions
    mapper('n', 'gf',        '<cmd>lua vim.lsp.buf.formatting()<CR>')
    mapper('n', 'gR',        '<cmd>lua vim.lsp.buf.rename()<CR>')

    -- Diagnostics
    mapper('n', '<leader>d',     '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    mapper('n', ']d',            '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    mapper('n', '[d',            '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
end

nvim_lsp.sumneko_lua.setup{
    cmd = {"lua-language-server"},
    settings = {
        Lua = {
            diagnostics = { globals = {"vim"} },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                }
            },
            telemetry = { enable = false },
        }
    },
    on_attach = on_attach, capabilities = lsp_cap
}

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb{ sign = { priority = 9 } }]]
EOF
