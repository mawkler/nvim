--------
-- zk --
--------

local function new_note()
  local ok, title = pcall(vim.fn.input, 'Note title: ');
  if ok and title and title ~= '' then
    require('zk').new({ title = title })
  end
end

return {
  'mickael-menu/zk-nvim',
  requires = 'nvim-lua/plenary.nvim',
  cmd = { 'ZkIndex', 'ZkNew', 'ZkCd', 'ZkNotes', 'ZkBacklinks', 'ZkLinks', 'ZkTags' },
  keys = {
    { '<leader>zn', new_note, desc = 'New note' },
    { '<leader>zn', '<Cmd>ZkNewFromContentSelection<CR>', mode = 'x', desc = 'New note from selection' },
    { '<leader>zf', '<Cmd>ZkNotes { sort = { "modified" } }<CR>', desc = 'Find notes' },
    { '<leader>zt', '<Cmd>ZkTags<CR>', desc = 'Note tags' },
    { '<leader>zc', '<Cmd>ZkCd<CR>', desc = 'Change to notes directory' },
    { '<leader>z/', ":'<,'>ZkMatch<CR>", mode = 'x', desc = 'Find in notes' },
    { '<leader>z/', '<Cmd>ZkNotes { sort = { "modified" }, match = { vim.fn.input("Search: ") } }<CR>', desc = 'Find in notes' },
  },
  config = function()
    require('zk').setup({
      picker = 'telescope',
      lsp = {
        config = {
          on_attach = function()
            local map = require('utils').map

            map('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>',             'Note backlinks')
            map('n', '<leader>zl', '<Cmd>ZkInsertLink<CR>',            'Link to note')
            map('x', '<leader>zl', '<Cmd>ZkInsertLinkAtSelection<CR>', 'Link to note')
            map('n', '<leader>zL', '<Cmd>ZkLinks<CR>',                 'Note links')
          end
        }
      }
    })
  end
}
