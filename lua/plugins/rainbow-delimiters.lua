return {
    "HiPhish/rainbow-delimiters.nvim",
    init = function()
        vim.g.rainbow_delimiters = {
            condition = function(bufnr)
                if vim.bo[bufnr].buftype ~= ""
                    or vim.bo[bufnr].filetype == "alpha" then
                    return false
                end

                local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
                return ok and parser ~= nil
            end,
        }
    end,
}
