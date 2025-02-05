local function getLatestMessages(count)
  local messages = vim.fn.execute('messages')
  local lines = vim.split(messages, '\n')
  lines = vim.tbl_filter(function(line) return line ~= '' end, lines)
  count = count and tonumber(count) or nil
  count = (count ~= nil and count > 0) and count - 1 or #lines
  return table.concat(vim.list_slice(lines, #lines - count), '\n')
end

local function yankMessages(register, count)
  local default_register = '+'
  register = (register and register ~= '') and register or default_register
  vim.fn.setreg(register, getLatestMessages(count), 'l')
end

vim.api.nvim_create_user_command('YankMessages', function(opts)
  return yankMessages(opts.reg, opts.count)
end, { count = 10, register = true })
