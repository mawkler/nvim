--------------
-- nvim-ufo --
--------------
return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    local ufo = require('ufo')

    vim.o.foldcolumn = 'auto'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99

    vim.opt.fillchars:append({foldclose = ''})
    vim.opt.fillchars:append({foldopen = ''})
    vim.opt.fillchars:append({foldopen = ' '})
    vim.opt.fillchars:append({fold = ' '})
    vim.opt.fillchars:append({foldsep = ' '})

    vim.keymap.set('n', 'zR', ufo.openAllFolds)
    vim.keymap.set('n', 'zM', ufo.closeAllFolds)

    -- From nvim-ufo's README
    local function handler(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (' 󰉸 %d '):format(endLnum - lnum + 1)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0

      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, {chunkText, hlGroup})
          chunkWidth = vim.fn.strdisplaywidth(chunkText)

          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end

      table.insert(newVirtText, { suffix, 'CodeLens' })
      return newVirtText
    end

    ---@diagnostic disable-next-line: missing-fields
    ufo.setup({
      open_fold_hl_timeout = 0,
      close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
      },
      fold_virt_text_handler = handler,
    })
  end
}
