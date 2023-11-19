--------------------------------------
-- Treesitter Context Commentstring --
--------------------------------------
return {
   'JoosepAlviste/nvim-ts-context-commentstring',
  lazy = true,
  init = function()
    vim.g.skip_ts_context_commentstring_module = true
  end,
  opts = {
    enable = true,
    enable_autocmd = false,
  }
}
