local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("user.keymaps")
require("lazy").setup("plugins")
require("user.options")

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cs' },
    callback = function ()
        vim.treesitter.start()
    end
})
