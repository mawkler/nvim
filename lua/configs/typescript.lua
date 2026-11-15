----------------
-- TypeScript --
----------------
-- The language server is TypeScript 7's built-in one, see `tsc` in `lsp.lua`
return {
  -- Prettier TypeScript errors (in its own windows)
  'youyoumu/pretty-ts-errors.nvim',
  ft = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
  opts = { auto_open = false },
}
