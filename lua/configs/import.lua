------------
-- Import --
------------
return { 'miversen33/import.nvim',
  requires = { 'miversen33/netman.nvim', branch = 'issue-28-libuv-shenanigans' },
  config = function()
    import('netman', function(netman) netman.init() end)
  end
}

