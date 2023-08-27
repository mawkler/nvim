-----------
-- Alpha --
-----------
return {
  'goolord/alpha-nvim',
  dependencies = 'kyazdani42/nvim-web-devicons',
  event = 'VimEnter',
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    local lazy = require('lazy')
    local section = dashboard.section
    local fn = vim.fn

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
      dashboard.button('<Leader>s', '  Sessions'),
      dashboard.button('<Leader>m', '  Most recent files'),
      dashboard.button('<C-p>',     '  Find file'),
      dashboard.button('i',         '  New file',           ':enew <BAR> startinsert<CR>'),
      dashboard.button('<C-q>',     '  Quit'),
    }

    -- Footer
    local Footer = { items = {} }

    function Footer:add(icon, item, condition)
      if condition == nil or condition then
        table.insert(self.items, string.format('%s %s', icon, tostring(item)))
      end
    end

    function Footer:create()
      return table.concat(self.items, '  |  ')
    end

    local lazy_stats = lazy.stats()
    local loaded_plugins = string.format(
      '%d/%d plugins',
      lazy_stats.loaded,
      lazy_stats.count
    )

    local version = vim.version() or {}
    local date = os.date('%d-%m-%Y')
    local version_string = string.format(
      'v%s.%d.%d',
      version.major,
      version.minor,
      version.patch
    )

    Footer:add('', loaded_plugins)
    Footer:add('', version_string)
    Footer:add('', date)

    section.footer.val = Footer:create()
    section.footer.opts.hl = 'NonText'

    -- Layout
    local topMarginRatio = 0.2
    local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * topMarginRatio) })

    dashboard.config.layout = {
      { type = 'padding', val = headerPadding },
      section.header,
      { type = 'padding', val = 2 },
      section.buttons,
      { type = 'padding', val = 2 },
      section.footer,
    }

    alpha.setup(dashboard.opts)
  end
}
