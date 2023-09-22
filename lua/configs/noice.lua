-----------
-- Noice --
-----------

local function create_skip_filter(pattern)
  return {
    filter = { event = 'msg_show', find = pattern, },
    opts = { skip = true },
  }
end

local disabled_message_prefixes = {
  '^[/?].*',                  -- Search up/down
  'E486: Pattern not found:', -- Search not found
  '%d+ changes?;',            -- Undo/redo
  '"[^"]+" %d+L, %d+B'        -- Save
}

local filter_message_routes = vim.tbl_map(create_skip_filter, disabled_message_prefixes)
local other_routes = {
  { view = "split", filter = { event = "msg_show", min_height = 20 } },
}

return {
  'folke/noice.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
  config = function()
    local noice = require('noice')
    local map = require('utils').map

    noice.setup({
      routes = vim.list_extend(filter_message_routes, other_routes),
      presets = {
        lsp_doc_border = true,
      },
      cmdline = {
        format = {
          search_up = { kind = 'search', pattern = '^%?', icon = ' 󰜷', lang = 'regex' },
          search_down = { kind = 'search', pattern = '^/', icon = ' 󰜮', lang = 'regex' },
        }
      }
    })

    map('n', 'gl', function() noice.cmd('last') end, 'Show last message')
    map('n', 'gm', '<cmd>messages<CR>', 'Show messages in a floating window')
  end
}
