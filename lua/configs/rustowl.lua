-------------
-- RustOwl --
-------------
return {
  'cordx56/rustowl',
  version = '*',
  build = 'cd rustowl && cargo install --path . --locked',
  lazy = false,
  opts = {
    idle_time = 300,
    client = {
      on_attach = function(_, buf)
        vim.keymap.set('n', '<leader>lo', function()
          require('rustowl').toggle(buf)
        end, { buffer = buf, desc = 'Toggle RustOwl' })
      end
    },
  },
}
