-- nvim-lspconfig
local nvim_lsp = require('lspconfig')

-- lsp-status.nvim
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- nvim-lightbulb
vim.fn.sign_define("LightBulbSign", { text = "󱉵", texthl = "LspDiagnosticsSignWarning" })
vim.cmd (
    [[ autocmd CursorHold * lua require("nvim-lightbulb").update_lightbulb { sign_priority = 5 } ]]
)

-- nvim-compe
require("compe").setup({
    enabled = true;
    source = {
        path = true;
        buffer = true;
        vsnip = true;
        nvim_lsp = true;
    }
})

-- nvim-telescope
local format_telescope = function(picker)
    return string.format("<cmd> lua require('telescope.builtin').%s()<CR>", picker)
end

-- LSP configuration
local on_attach = function(_)
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    local mapper = function(mode, key, result)
        vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
    end

    -- Information and search
    mapper('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>')
    mapper('n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>')
    mapper('n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>')
    mapper('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>')
    mapper('n', 'gr',        format_telescope('lsp_references'))
    mapper('n', 'gt',        '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    mapper('n', 'gw',        format_telescope('lsp_document_symbols'))
    mapper('n', 'gW',        format_telescope('lsp_workspace_symbols'))

    -- Actions
    mapper('n', 'ga',        format_telescope('lsp_code_actions'))
    mapper('n', 'gf',        '<cmd>lua vim.lsp.buf.formatting()<CR>')
    mapper('n', 'gR',        '<cmd>lua vim.lsp.buf.rename()<CR>')

    -- Diagnostics
    mapper('n', '<leader>d',     '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    mapper('n', ']d',            '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    mapper('n', '[d',            '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')

    -- Rust specific stuff
    if filetype == 'rustlalalala' then
        -- Inlay hints
        vim.cmd(
            [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
            .. [[aligned = true, prefix = " » ", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}]]
            .. [[} ]]
        )

        -- Auto format files
        vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
    end
end

-- Set up LSP capabilities (This line doesn't do anything atm)
local lsp_cap = vim.tbl_extend('keep', lsp_cap or {}, lsp_status.capabilities)

-- Setup LSP servers
nvim_lsp.rust_analyzer.setup{
    on_attach=on_attach,
    capabilities = lsp_cap,
    settings = {
        ['rust-analyzer'] = {
            cargo = { allFeatures = true, autoReload = true },
            checkOnSave = {
                enable=true, command = "clippy",
            },
        }
    }
}
nvim_lsp.clangd.setup{on_attach = on_attach, capabilities = lsp_cap}
nvim_lsp.ghcide.setup{on_attach = on_attach, capabilities = lsp_cap}
nvim_lsp.texlab.setup{on_attach = on_attach, capabilities = lsp_cap}

nvim_lsp.sumneko_lua.setup{
    cmd = {"lua-language-server"},
    on_attach = on_attach, capabilities = lsp_cap
}

nvim_lsp.pyright.setup{
    cmd = { "pyright-langserver", "--stdio" },
    on_attach = on_attach, capabilities = lsp_cap,
}

nvim_lsp.svelte.setup{on_attach = on_attach, capabilities = lsp_cap}
nvim_lsp.diagnosticls.setup{
    on_attach = on_attach, capabilities = lsp_cap,
    filetypes = { "python", "sh", "bash", "tex" },
    init_options = {
        filetypes = {
            python = "flake8", sh = "shellcheck", bash = "shellcheck",
            tex = "textidote"
        },
        linters = {
            flake8 = {
                command = "flake8",
                debounce = 100,
                args = { "--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s", "-" },
                offsetLine =  0,
                offsetColumn = 0,
                sourceName = "flake8",
                formatLines = 1,
                formatPattern = {
                    "(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$",
                    {
                        line = 1,
                        column =  2,
                        security = 3,
                        message = 4
                    }
                },
                securities = {
                    W = "warning",
                    E = "error",
                    F = "error",
                    C = "error",
                    N = "error"
                }
            },
            shellcheck = {
                command = "shellcheck",
                debounce = 100,
                args = { "--format", "json", "-" },
                sourceName = "shellcheck",
                parseJson = {
                    line = "line",
                    column = "column",
                    endLine = "endLine",
                    endColumn = "endColumn",
                    message = "${message} [${code}]",
                    security = "level"
                },
                securities = {
                    error = "error",
                    warning = "warning",
                    info = "info",
                    style = "hint"
                }
            },
            textidote = {
                command = "textidote",
                debounce = 500,
                args = {"--type", "tex", "--check", "en", "--output", "singleline", "--no-color"},
                offsetLine = 0,
                offsetColumn = 0,
                sourceName = "textidote",
                formatLines = 1,
                formatPattern = {
                    "\\(L(\\d+)C(\\d+)-L(\\d+)C(\\d+)\\):(.+)\".+\"$",
                    {
                      line = 1,
                      column = 2,
                      endLine = 3,
                      endColumn = 4,
                      message = 5
                    }
                },
            }
        }
    }
}

-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {"c", "python", "rust"},
  highlight = {
    enable = true
  },
}

-- Diagnostics
vim.fn.sign_define("LspDiagnosticsSignError", { text = "", numhl = "LspDiagnosticsSignError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "LspDiagnosticsSignWarning" })
vim.fn.sign_define(
    "LspDiagnosticsSignInformation", { text = "", numhl = "LspDiagnosticsSignInformation" }
)
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", numhl = "LspDiagnosticsSignHint" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)
