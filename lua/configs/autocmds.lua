---------------
-- Autocmds --
---------------
local autocmd = require('../utils').autocmd

autocmd('TextYankPost', { -- Highlight text object on yank
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350 })
  end,
  group = 'HighlightYank'
})

-- TypeScript specific --
autocmd('FileType', {
  pattern = 'typescript',
  callback = function()
    vim.opt.matchpairs:append('<:>')
  end,
  group = 'TypeScript'
})

-- Disabled until TSLspOrganize and/or TSLspImportAll doesn't collide with
--     ['*.ts,*.tsx'] = function()
--       if b.format_on_write ~= false then
--         cmd 'TSLspOrganize'
--         cmd 'TSLspImportAll'
--       end
--     end
--   }
-- }
