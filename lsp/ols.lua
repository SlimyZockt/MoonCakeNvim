---@brief
---
--- https://github.com/DanielGavin/ols
---
--- `Odin Language Server`.

local util = require 'lspconfig.util'

return {
    cmd = { 'ols' },
    filetypes = { 'odin' },
    init_options = {
        enable_inlay_hints = true,
        enable_checker_only_saved = false,
        verbose = true,
        enable_fake_methods = true,
        enable_procedure_snippet = true,
        enable_rename = true,
        enable_references = true,
        enable_document_symbols = true,
        checker_args = '-strict-style -vet',
    },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        on_dir(util.root_pattern('ols.json', '.git', '*.odin')(fname))
    end,
}
