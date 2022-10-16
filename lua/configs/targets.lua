vim.g.targets_aiAI = 'aIAi' -- Swaps meaning of `I` and `i`

return {
  'wellle/targets.vim', -- Adds arguments, etc. as text objects
  config = function()
    vim.api.nvim_create_augroup('Targets', {})
    vim.api.nvim_create_autocmd('User', {
      pattern = 'targets#mappings#user',
      callback = function()
        vim.fn['targets#mappings#extend']({
          b = { pair  = {{ o = '(', c = ')' }} },
          r = { pair  = {{ o = '[', c = ']' }} },
          q = { quote = {{ d = "'" }} },
          Q = { quote = {{ d = '"' }} },
          A = { quote = {{ d = '`' }} },
          a = {},
        })
      end,
      group = 'Targets',
    })
  end
}
