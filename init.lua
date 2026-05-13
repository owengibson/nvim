local function prepend_existing_paths(paths)
  local path_sep = package.config:sub(1, 1) == "\\" and ";" or ":"
  local existing = {}

  for _, path in ipairs(paths) do
    if path ~= "" and (vim.uv or vim.loop).fs_stat(path) then
      existing[#existing + 1] = path
    end
  end

  if #existing > 0 then
    vim.env.PATH = table.concat(existing, path_sep) .. path_sep .. vim.env.PATH
  end
end

local tree_sitter_packages = vim.fn.glob(
  vim.fn.expand("$LOCALAPPDATA") .. "/Microsoft/WinGet/Packages/tree-sitter.tree-sitter-cli_*",
  false,
  true
)
local is_vscode = vim.g.vscode ~= nil

prepend_existing_paths({
  "C:/Program Files/nodejs",
  "C:/Program Files/LLVM/bin",
  vim.fn.expand("$APPDATA") .. "/npm",
  tree_sitter_packages[1] or "",
})

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

if is_vscode then
  require("lazy").setup(require("user.vscode_plugins"))
else
  require("lazy").setup("plugins")
end

require("user.options")

if not is_vscode then
  vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'cs' },
      callback = function ()
          vim.treesitter.start()
      end
  })
end
