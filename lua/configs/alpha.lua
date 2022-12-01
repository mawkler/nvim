-----------
-- Alpha --
-----------
return { 'goolord/alpha-nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
  event = 'VimEnter',
  config = function ()
    import('alpha', function(alpha)
      local dashboard = require('alpha.themes.dashboard')
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

      local loaded_plugins_count = #vim.tbl_filter(function(plugin)
        return plugin.loaded
      end, packer_plugins)
      local total_plugins_count = #vim.tbl_keys(packer_plugins)
      local loaded_plugins = string.format(
        '%d/%d plugins',
        loaded_plugins_count,
        total_plugins_count
      )

      local version = vim.version()
      local date = os.date('%d-%m-%Y')
      local version_string = string.format(
        'v%s.%d.%d',
        version.major,
        version.minor,
        version.patch
      )
      local import_failure_count = require('import').get_failure_count()

      Footer:add(
        '',
        tostring(import_failure_count) .. ' import(s) failed',
        import_failure_count > 0
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
    end)
  end
}
