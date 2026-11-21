-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local indent = {
  [2] = {
    "html",
    "css",
    "javascript",
    "typescript",
    "typescriptreact",
    "lua",
    "nix",
    "json",
    "ruby",
    "eruby",
    "embedded_template",
  },
  [4] = { "go", "rust" },
}

local group = vim.api.nvim_create_augroup("kingscott_indent", { clear = true })
for width, filetypes in pairs(indent) do
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = filetypes,
    callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.smartindent = true
      vim.opt_local.tabstop = width
      vim.opt_local.shiftwidth = width
      vim.opt_local.softtabstop = width
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "go",
  callback = function()
    vim.opt_local.list = false
  end,
})
