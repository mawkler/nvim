---------------
-- Headlines --
---------------
return {
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    ft = { 'markdown', 'orgmode', 'neorg' },
    opts = {
      markdown = {
        fat_headline_upper_string = "▄",
        fat_headline_lower_string = "▀",
        bullets = { "󰇊", "󰇋", "󰇌", "󰇍" },
      }
    }
  },
}
