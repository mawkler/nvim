-----------------
-- Leap spooky --
-----------------
return {
  'ggandor/leap-spooky.nvim',
  config = function()
    require('leap-spooky').setup({
      extra_textobjects = { 'if', 'af' },
      affixes = {
        remote = { window = 'z', cross_window = 'Z' },
      },
    })

    ---@param key string Key, not including i/a, for example `f` to create spooky `if`/`af`
    ---@param name? string
    local function create_spooky_textobject(key, name)
      for _, preposition in pairs({ 'i', 'a' }) do
        local lhs = preposition .. 'z' .. key
        local preposition_full = preposition == 'i' and 'inside' or 'around'

        vim.keymap.set('o', lhs, function()
          local action = require('leap-spooky').spooky_action(
            function() return 'v' .. preposition .. key end,
            { keeppos = true, on_return = (vim.v.operator == 'y') and 'p' }
          )

          require('leap').leap {
            target_windows = { vim.fn.win_getid() },
            action = action,
          }
        end, { desc = ('Spooky %s %s'):format(preposition_full, name or '') })
      end
    end

    local ts_keymaps = require('configs.treesitter.keymaps').get()
    for lhs, textobject in pairs(ts_keymaps) do
      create_spooky_textobject(lhs, textobject)
    end
  end
}
