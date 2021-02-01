local diagnostics = require('lsp-status/diagnostics')

local function statusline()
  if #vim.lsp.buf_get_clients() == 0 then
    return ''
  end

  local buf_diagnostics = diagnostics()

  local errors = ""
  local warnings = ""
  local info = ""
  local hints = ""

  if buf_diagnostics.errors and buf_diagnostics.errors > 0 then
    errors = "%#LspStatusError# 󰅚  "..buf_diagnostics.errors
  end

  if buf_diagnostics.warnings and buf_diagnostics.warnings > 0 then
    warnings = "%#LspStatusWarning# 󰗖  "..buf_diagnostics.warnings
  end

  if buf_diagnostics.info and buf_diagnostics.info > 0 then
    info = "%#LspStatusInformation# 󰙎 "..buf_diagnostics.info
  end

  if buf_diagnostics.hints and buf_diagnostics.hints > 0 then
    hints = "%#LspStatusHint# 󱉵  "..buf_diagnostics.hints
  end

  return errors..warnings..info..hints
end

local M = {
  status = statusline
}

return M
