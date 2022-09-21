-----------
-- Alpha --
-----------
return { 'goolord/alpha-nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function ()
    import('alpha', function(alpha)
      local dashboard = require('alpha.themes.dashboard')
      local section = dashboard.section
      local fn = vim.fn

      local function footer()
        local plugin_count = #vim.tbl_keys(packer_plugins)
        local version = vim.version()
        local date = os.date('%d-%m-%Y')
        local version_string = string.format(
          'v%s.%d.%d',
          version.major,
          version.minor,
          version.patch
        )

        return string.format(
          ' %d plugins  |   %s  |   %s',
          plugin_count,
          version_string,
          date
        )
      end


      -- Header
      section.header.opts.hl = 'AlphaHeader'
      section.header.val = {
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '                                                     ',
      }

      -- Menu
      section.buttons.val = {
        dashboard.button('i',         '  New file',           ':enew <BAR> startinsert<CR>'),
        dashboard.button('<Leader>s', '  Sessions'),
        dashboard.button('<Leader>m', '  Most recent files'),
        dashboard.button('<C-p>',     '  Find file'),
        dashboard.button('<C-q>',     '  Quit'),
      }

      -- Footer
      section.footer.val = footer()
      section.footer.opts.hl = 'NonText'

      -- Layout
      local topMarginRatio = 0.2
      local headerPadding = fn.max({2, fn.floor(fn.winheight(0) * topMarginRatio)})

      dashboard.config.layout = {
        { type = 'padding', val = headerPadding },
        section.header,
        { type = 'padding', val = 2 },
        section.buttons,
        { type = 'padding', val = 2 },
        section.footer,
      }

      alpha.setup(dashboard.opts)
    end)
  end
}
