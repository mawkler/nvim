----------
-- Namu --
----------
return {
  'bassamsdata/namu.nvim',
  keys = {
    { '<leader>S', '<cmd>Namu symbols<cr>', mode = { 'n', 'x' }, desc = 'Jump to LSP symbol', silent = true },
  },
  cmd = 'Namu',
  config = function()
    require('namu').setup({
      namu_symbols = {
        options = {
          movement = {
            next       = { '<C-j>' },
            previous   = { '<C-k>' },
            clear_line = { '<C-u>' },
            close      = { '<ESC>', '<C-c>' },
          },
          AllowKinds = {
            default = { 'Function', 'Method', 'Class', 'Module', 'Interface' },
          },

          window = { title_prefix = ' ', },
          row_position = 'top10_right',
          kindIcons = require('utils.icons')
        },
      },
    })

    local highlights = {
      ['NamuCurrentLine']    = 'PmenuSel',
      ['@lsp.type.module']   = '@lsp.type.namespace',
      ['@lsp.type.field']    = '@lsp.type.property',
      ['@lsp.type.constant'] = '@lsp.type.enumMember',
    }

    for hl, link_to in pairs(highlights) do
      vim.api.nvim_set_hl(0, hl, { link = link_to, default = true })
    end
  end
}
