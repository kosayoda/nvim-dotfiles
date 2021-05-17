-- nvim-lspconfig
local nvim_lsp = require('lspconfig')

-- lsp-status.nvim
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- nvim-lightbulb
vim.fn.sign_define("LightBulbSign", { text = "󱉵", texthl = "LspDiagnosticsSignWarning" })
vim.cmd (
    [[ autocmd CursorHold,CursorHoldI * lua LightBulbFunc() ]]
)
LightBulbFunc = function()
    require("nvim-lightbulb").update_lightbulb {
        sign = { enabled = true },
        -- virtual_text = { enabled = false, text = "󱉵 ", column = -1, text_pos = "overlay"},
        -- float = { enabled = false, text = "󱉵 "},
    }
end

-- nvim-telescope
local telescope = function(picker)
    return string.format("<cmd> lua require('telescope.builtin').%s()<CR>", picker)
end

-- LSP configuration
local on_attach = function(_)
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    local mapper = function(mode, key, result)
        vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
    end

    -- Information and search
    mapper('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>')
    mapper('n', 'gd',        '<cmd>lua vim.lsp.buf.declaration()<CR>')
    mapper('n', 'gD',        '<cmd>lua vim.lsp.buf.definition()<CR>')
    mapper('n', 'gr',        telescope('lsp_references'))
    mapper('n', 'gw',        telescope('lsp_document_symbols'))
    -- mapper('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>')
    -- mapper('n', 'gt',        '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- mapper('n', 'gW',        telescope('lsp_workspace_symbols'))

    -- Actions
    mapper('n', 'ga',        telescope('lsp_code_actions'))
    mapper('n', 'gf',        '<cmd>lua vim.lsp.buf.formatting()<CR>')
    mapper('n', 'gR',        '<cmd>lua vim.lsp.buf.rename()<CR>')

    -- Diagnostics
    mapper('n', '<leader>d',     '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    mapper('n', ']d',            '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    mapper('n', '[d',            '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')

    -- Rust specific stuff
    if filetype == 'rust' then
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
                enable = true, command = "clippy",
            },
            hoverActions = {
                linksInHover = false
            }
        }
    }
}
nvim_lsp.clangd.setup{on_attach = on_attach, capabilities = lsp_cap}
nvim_lsp.ghcide.setup{on_attach = on_attach, capabilities = lsp_cap}
nvim_lsp.texlab.setup{on_attach = on_attach, capabilities = lsp_cap}

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

nvim_lsp.pyright.setup{
    cmd = { "pyright-langserver", "--stdio" },
    on_attach = on_attach, capabilities = lsp_cap,
}

nvim_lsp.tsserver.setup{
    on_attach = on_attach, capabilities = lsp_cap,
}

nvim_lsp.svelte.setup{on_attach = on_attach, capabilities = lsp_cap}

local efm = {
    flake8 = {
        lintCommand = "flake8 --stdin-display-name ${INPUT} -",
        lintIgnoreExitCode = true,
        lintStdin = true,
        lintFormats = { "%f:%l:%c: %m" },
        rootMarkers = { "setup.cfg", "tox.ini", ".flake8" },
    },
    shellcheck = {
        lintCommand = "shellcheck -f gcc -x",
        lintStdin = true,
        lintFormats = "%f:%l:%c: %t%*[^:]: %m [SC%n]",
    }
}
nvim_lsp.efm.setup {
    settings = {
        lintDebounce = 1000000000,
        languages = {
            python = { efm.flake8 },
            sh = { efm.shellcheck },
        }
    }
}

-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
      "c", "lua", "python", "rust",
      "html", "css", "javascript", "typescript", "svelte",
      "bash", "toml", "rst", "json", "latex",
  },
  highlight = { enable = true },
  -- indent = { enable = true }
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
