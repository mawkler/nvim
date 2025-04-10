-------------------------
-- Various textobjects --
-------------------------

local augroup = vim.api.nvim_create_augroup('VariousTextobjsCustom', {})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  group = augroup,
  callback = function(event)
    local function map(lhs, rhs)
      vim.keymap.set({ 'o', 'x' }, lhs, rhs, { buffer = event.buf })
    end

    map('iX', function() require('various-textobjs').mdLink('inner') end)
    map('aX', function() require('various-textobjs').mdLink('outer') end)
    map('ic', function() require('various-textobjs').mdFencedCodeBlock('inner') end)
    map('ac', function() require('various-textobjs').mdFencedCodeBlock('outer') end)
  end,
})

return {
  'chrisgrieser/nvim-various-textobjs',
  event = 'VeryLazy',
  config = function()
    local map = require('utils').map
    local various_textobjs = require('various-textobjs')

    various_textobjs.setup({
      textobjs = {
        subword = {
          noCamelToPascalCase = false,
        },
      },
      keymaps = {
        useDefaults = true,
        disabledDefaults = {
          'ig', -- Replaced with iG
          'ag', -- Replaced with aG
          'gG', -- Replaced with ie
          '|',  -- Disabled
          'L',  -- Replaced with ix
          'r',  -- I only want this for normal mode
          '=',  -- Use Treesitter's @assignment instead
          'il', -- Replaced with iL
          'al', -- Replaced with aL
          'ic', -- Disabled (CSS class)
          'ac', -- Disabled (CSS class)
          'ix', -- Replaced with iX
          'ax', -- Replaced with iX
          'iD', -- Use vim-textobj-user's date instead
          'aD', -- Use vim-textobj-user's date instead
          'iS', -- Replaced with i-
          'aS', -- Replaced with a-
          'in', -- Disabled, use treesitter's iN, instead
          'an', -- Disabled, use treesitter's aN, instead
          'ie', -- Remapped to iE
          'ae', -- Remapped to aE
          'n',  -- Disabled
          'iz', -- Remapped to iZ
          'az', -- Remapped to aZ
        },
      },
    })

    local ox = { 'o', 'x' }
    map(ox, 'iG', function() various_textobjs.greedyOuterIndentation('inner') end,   'Inside greedy indentation')
    map(ox, 'aG', function() various_textobjs.greedyOuterIndentation('outer') end,   'Around greedy indentation')
    map(ox, 'ie', various_textobjs.entireBuffer,                                     'Entire buffer')
    map(ox, 'iL', function() return various_textobjs.lineCharacterwise('inner') end, 'Line')
    map(ox, 'aL', function() return various_textobjs.lineCharacterwise('outer') end, 'Line')
    map(ox, 'ix', various_textobjs.url,                                              'URL')
    map(ox, 'id', various_textobjs.diagnostic,                                       'Diagnostic')
    map(ox, 'iX', function() return various_textobjs.htmlAttribute('inner') end,     'HTML attribute')
    map(ox, 'aX', function() return various_textobjs.htmlAttribute('outer') end,     'HTML attribute')
    map(ox, 'i-', function() return various_textobjs.subword('inner') end,           'Inside subword')
    map(ox, 'a-', function() return various_textobjs.subword('outer') end,           'Aroun subword')
    map(ox, 'iE', function() return various_textobjs.mdEmphasis('inner') end,        'Markdown emphasis')
    map(ox, 'aE', function() return various_textobjs.mdEmphasis('outer') end,        'Markdown emphasis')
    map(ox, ']}', function() return various_textobjs.toNextClosingBracket() end,     'To next closing bracket')
    map(ox, '[{', function() return various_textobjs.toNextClosingBracket() end,     'To previous closing bracket')

    ---@param preposition 'inner' | 'outer'
    local function subword(preposition)
      return function()
        ---@diagnostic disable-next-line: missing-fields
        various_textobjs.setup({
          textobjs = {
            subword = {
              noCamelToPascalCase = preposition == 'outer',
            },
          },
        })

        various_textobjs.subword(preposition)
      end
    end

    map({ 'o', 'x' }, 'i-', subword('inner'), 'Inside subword')
    map({ 'o', 'x' }, 'a-', subword('outer'), 'Around subword')

    -- Copied from README
    map('n', 'dsi', function()
      -- select inner indentation
      various_textobjs.indentation('inner', 'inner')

      -- Plugin only switches to visual mode when a textobj has been found
      local notOnIndentedLine = vim.fn.mode():find('V') == nil
      if notOnIndentedLine then
        return
      end

      -- Dedent indentation
      vim.cmd.normal { '<', bang = true }

      -- Delete surrounding lines
      local endBorderLn = vim.api.nvim_buf_get_mark(0, '>')[1] + 1
      local startBorderLn = vim.api.nvim_buf_get_mark(0, '<')[1] - 1
      vim.cmd(tostring(endBorderLn) .. ' delete') -- delete end first so line index is not shifted
      vim.cmd(tostring(startBorderLn) .. ' delete')
    end, { desc = 'Delete surrounding indentation' })
  end
}
