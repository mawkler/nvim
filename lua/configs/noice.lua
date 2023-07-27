-----------
-- Noice --
-----------

local function create_skip_filter(pattern)
  return {
    filter = { event = 'msg_show', find = pattern, },
    opts = { skip = true },
  }
end

local disabled_message_prefixes = {'^[/?].*', 'E486: Pattern not found:'}

local filter_message_routes = vim.tbl_map(create_skip_filter, disabled_message_prefixes)
local other_routes = {
  { view = "split", filter = { event = "msg_show", min_height = 20 } },
}

return {
  'folke/noice.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
  event = 'VimEnter',
  opts = {
    routes = vim.list_extend(filter_message_routes, other_routes)
  }
}
