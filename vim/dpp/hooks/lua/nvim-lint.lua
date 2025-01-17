--- [nvim-lint](https://github.com/mfussenegger/nvim-lint)
--- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.

-- lua_source {{{

print("Loading nvim-lint.lua")

-- local mason_lspconfig = require('mason-lspconfig')

-- install linter via mason
-- local linters = {
--   "flake8",
-- }
-- 
-- mason_lspconfig.setup({
--     ensure_installed = linters,
--     automatic_installation = true,
-- })
-- 
-- Setup
require("lint").linters_by_ft = {
  python = { "flake8", "dmypy" },
}

vim.api.nvim_create_autocmd(
  {
    'LspAttach',
    "CursorHold",
    "BufWinEnter",
    "InsertLeave",
    "BufModifiedSet",
    "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
    "CursorHoldI",
  },
  {
    group = vim.api.nvim_create_augroup("NvimLintConfig", {}),
    pattern = "*",
    callback = function()
      require("lint").try_lint()
    end,
  }
)
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
-- 
--     -- try_lint without arguments runs the linters defined in `linters_by_ft`
--     -- for the current filetype
--     require("lint").try_lint()
-- 
--     -- You can call `try_lint` with a linter name or a list of names to always
--     -- run specific linters, independent of the `linters_by_ft` configuration
--     require("lint").try_lint("cspell")
--   end,
-- })
-- 
-- }}}
