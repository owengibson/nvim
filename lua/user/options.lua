vim.opt.relativenumber = true
vim.opt.number = true
vim.g.have_nerd_font = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.diagnostic.config({
    virtual_text = {
        spacing = 2,
        prefix = "●",
        severity = { min = vim.diagnostic.severity.WARN }
    },
    signs = true,
    underline = {
        severity = { min = vim.diagnostic.severity.WARN }
    },
    update_in_insert = false
})
