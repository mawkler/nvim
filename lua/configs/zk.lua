--------
-- zk --
--------

local function new_note()
  local ok, title = pcall(vim.fn.input, 'Note title: ');
  if ok and title and title ~= '' then
    require('zk').new({ title = title })
  end
end

local search_notes = '<Cmd>ZkNotes { sort = { "modified" }, match = { vim.fn.input("Search: ") } }<CR>'

return {
  'mickael-menu/zk-nvim',
  requires = 'nvim-lua/plenary.nvim',
  cmd = { 'ZkIndex', 'ZkNew', 'ZkCd', 'ZkNotes', 'ZkBacklinks', 'ZkLinks', 'ZkTags' },
  keys = {
    { '<leader>zn', new_note,                                     desc = 'New note' },
    { '<leader>zn', ":'<,'>ZkNewFromTitleSelection<CR>",          desc = 'New note from selection',  mode = 'x' },
    { '<leader>zf', '<Cmd>ZkNotes { sort = { "modified" } }<CR>', desc = 'Find notes' },
    { '<leader>zt', '<Cmd>ZkTags<CR>',                            desc = 'Note tags' },
    { '<leader>zc', '<Cmd>ZkCd<CR>',                              desc = 'Change to notes directory' },
    { '<leader>z/', search_notes,                                 desc = 'Find in notes' },
    { '<leader>z/', ":'<,'>ZkMatch<CR>",                          desc = 'Find in notes',            mode = 'x' },
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
