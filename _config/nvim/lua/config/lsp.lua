-- vim.lsp.set_log_level("debug")
-- vim.lsp.set_log_level("trace")
-- require("vim.lsp.log").set_format_func(vim.inspect)

vim.diagnostic.config({ virtual_text = true })

vim.lsp.enable('sorbet')
