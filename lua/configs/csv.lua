---------
-- CSV --
---------
return { 'chrisbra/csv.vim',
  ft = 'csv',
  setup = function()
    -- Disable some default mappings
    vim.g.csv_nomap_W = 1
    vim.g.csv_nomap_E = 1
    vim.g.csv_nomap_L = 1
    vim.g.csv_nomap_H = 1
  end
}
