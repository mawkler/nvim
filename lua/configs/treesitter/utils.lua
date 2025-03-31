local map = vim.keymap.set

local M = {}

local augroup = vim.api.nvim_create_augroup('TreesitterTextobjectsConfig', {})

---@param preposition 'inner' | 'outer'
---@param node 'string'
---@return string
local function select_textobject_cmd(node, preposition)
  return ('<cmd>TSTextobjectSelect @%s.%s<CR>'):format(node, preposition)
end

---@param direction 'Next' | 'Previous'
---@param node 'string'
---@return string
local function goto_textobject_cmd(direction, node)
  return ('<cmd>TSTextobjectGoto%sStart @%s.outer<CR>'):format(direction, node)
end

---@param event vim.api.keyset.create_autocmd.callback_args
---@param keys table<string, { node: string, name?: string }>
function M.textobject_map(event, keys)
  for key, mapping in pairs(keys) do
    local name = mapping.name or mapping.node
    local opts = { desc = 'Select ' .. name .. ' textobject', buffer = event.buf }
    local xo = { 'x', 'o' }

    map(xo,  'i' .. key, select_textobject_cmd(mapping.node, 'inner'),  opts)
    map(xo,  'a' .. key, select_textobject_cmd(mapping.node, 'outer'),  opts)
    map('n', ']' .. key, goto_textobject_cmd('Next', mapping.node),     opts)
    map('n', '[' .. key, goto_textobject_cmd('Previous', mapping.node), opts)
  end
end

--- Creates treesitter textobject keymaps for `filetypes`
---@param filetypes string | string[]
---@param keys table<string, { node: string, name?: string }>
function M.filetype_keymaps(filetypes, keys)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    group = augroup,
    callback = function(event)
      M.textobject_map(event, keys)
    end,
  })
end

--- Creates treesitter textobject keymaps for all filetypes *except*
--- `excluded_filetypes`
---@param excluded_filetypes string[]
---@param keys table<string, { node: string, name?: string }>
function M.filetype_excluding_keymaps(excluded_filetypes, keys)
  vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    callback = function(event)
      if not vim.tbl_contains(excluded_filetypes, event.match) then
        M.textobject_map(event, keys)
      end
    end,
  })
end

return M
