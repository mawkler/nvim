--------------
-- nvim-ufo --
--------------
return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    local ufo = require('ufo')
    local map = require('utils').map

    vim.o.foldcolumn = 'auto'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99

    vim.opt.fillchars:append({ foldclose = '' })
    vim.opt.fillchars:append({ foldopen = '' })
    vim.opt.fillchars:append({ foldopen = ' ' })
    vim.opt.fillchars:append({ fold = ' ' })
    vim.opt.fillchars:append({ foldsep = ' ' })

    map('n', 'zR', ufo.openAllFolds,         'Open all folds')
    map('n', 'zr', ufo.openFoldsExceptKinds, 'Open all folds (except ignored)')
    map('n', 'zM', ufo.closeAllFolds,        'Close all folds')
    map('n', 'zm', ufo.closeFoldsWith,       'Close all folds with higher level')
    map('n', 'gh', function()
      if not ufo.peekFoldedLinesUnderCursor() then
        vim.lsp.buf.hover()
      end
    end, 'Peek fold/LSP hover')

    map('n', ']z', ufo.goNextClosedFold,     'Next closed fold')
    map('n', '[z', ufo.goPreviousClosedFold, 'Previous closed fold')
    map('n', ']Z', 'zj',                     { remap = false, desc = 'Next fold' })
    map('n', '[Z', 'zk',                     { remap = false, desc = 'Previous fold' })

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
          table.insert(newVirtText, { chunkText, hlGroup })
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
      provider_selector = function(_, ft, _)
        local lsp_fold_unsupported = {
          'markdown', 'zsh', 'css', 'html', 'python', 'json'
        }

        return vim.tbl_contains(lsp_fold_unsupported, ft)
            and { 'treesitter', 'indent' }
            or { 'lsp', 'indent' }
      end,
    })
  end
}
