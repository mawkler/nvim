---------
-- CSV --
---------
return { 'chrisbra/csv.vim',
  ft = 'csv',
  setup = function()
    vim.g.csv_default_delim = '\t'
    local disabled_mappings = {'e', 'l', 'h'}

    for _, map in pairs(disabled_mappings) do
      vim.g['csv_nomap_' .. map] = 1
    end
  end
}
