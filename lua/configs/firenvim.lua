--------------
-- Firenvim --
--------------

local function firenvim_config(config)
  return function()
    vim.api.nvim_create_autocmd({ 'UIEnter' }, {
      callback = function(_)
        local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == 'Firenvim' then
          assert(type(config), 'function')
          config()
        end
      end
    })
  end
end

local function resize_window_when_line_added()
  local max_height = 20
  local id = vim.api.nvim_create_augroup('ExpandLinesOnTextChanged', { clear = true })
  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
    group = id,
    callback = function(_)
      local height = vim.api.nvim_win_text_height(0, {}).all
      if height > vim.o.lines and height < max_height then
        vim.o.lines = height
      end
    end
  })
end

local function submit()
  vim.cmd('w')
  vim.fn['firenvim#press_keys']('<CR>')
end

vim.g.firenvim_config = {
  localSettings = {
    ['.*'] = {
      takeover = 'never',
    }
  }
}

return {
  'glacambre/firenvim',
  build = ':call firenvim#install(0)',
  cond = vim.g.started_by_firenvim ~= nil,
  init = firenvim_config(function()
    resize_window_when_line_added()

    local ni = { 'n', 'i' }
    vim.keymap.set('n', '<C-c>',  '<cmd>qa!<CR>', { desc = 'Quit without saving' })
    vim.keymap.set(ni,  '<C-CR>', '<cmd>x<CR>',   { desc = 'Save and quit' })
    vim.keymap.set(ni,  '<M-CR>', submit,         { desc = 'Submit' })
  end)
}
