--------------
-- Surround --
--------------
return { 'kylechui/nvim-surround',
  keys = {
    {'n', 's'},
    {'n', 'ds'},
    {'n', 'cs'},
    {'x', 's'},
  },
  module = 'nvim-surround',
  setup = function()
    local map = require('utils').map
    local augroup = 'Surround'

    map('n', 'S', 's$', { remap = true })

    local function filetype_surround(filetype, surrounds)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetype,
        callback = function()
          require('nvim-surround').buffer_setup({
            surrounds = surrounds
          })
        end,
        group = augroup,
      })
    end

    vim.api.nvim_create_augroup(augroup, {})

    -- filetype_surround('lua', {
    --   -- F = { 'function() return ', ' end' }
    --   add = function()
    --     return { { 'function() return ' }, { ' end' } }
    --   end,
    --   -- find = function()

    --   -- end,
    --   -- delete = function()

    --   -- end,
    --   -- change = {
    --   --   target = function()

    --   --   end,
    --   --   replacement = function()

    --   --   end,
    --   -- }
    -- })
    -- filetype_surround('markdown', {
    --   c = { { '```', '' }, { '', '```' } },
    -- })
    -- filetype_surround('tex', {
    --   c = function()
    --     return {
    --       '\\' .. vim.fn.input({ prompt = 'LaTex command: ' }) .. '{', '}'
    --     }
    --   end,
    -- })
  end,
  config = function()
    require('nvim-surround').setup({
      move_cursor = false,
      keymaps = {
        normal = 's',
        normal_cur = 'ss',
        visual = 's',
        visual_line = 'S',
      },
      aliases = {
        q = "'",
        Q = '"',
        A = '`',
      },
    })
  end
}
