-----------
-- jdtls --
-----------
return {
  'mfussenegger/nvim-jdtls',
  dependencies = 'williamboman/mason.nvim',
  ft = 'java',
  config = function()
    local function setup_jdtls()
      local mason_path = require('mason-core.path')
      local get_install_path  = require('utils').get_install_path

      local function map(modes, lhs, rhs, opts)
        if type(opts) == 'string' then
          opts = { desc = opts }
        end
        opts = vim.tbl_extend('keep', opts, { buffer = true })
        return require('utils').map(modes, lhs, rhs, opts)
      end

      local config = {
        cmd = { mason_path.concat({ get_install_path('jdtls'), 'jdtls' }) },
        settings = {
          java = {
            on_attach = function()
              -- print('jdtls attached')
              local jdtls = require('jdtls')
              local nx = {'n', 'x'}

              map('n', '<leader>lo',  jdtls.organize_imports, 'Organize imports')
              map(nx,  '<leader>lev', jdtls.extract_variable, 'Extract variable')
              map(nx,  '<leader>lec', jdtls.extract_constant, 'Extract constant')
              map(nx,  '<leader>lem', jdtls.extract_method,   'Extract method')

              -- If using nvim-dap
              -- This requires java-debug and vscode-java-test bundles, see
              -- install steps in this README further below.
              -- map('n', '<leader>df', jdtls.test_class)
              -- map('n', '<leader>dn', jdtls.test_nearest_method)
            end
          },
        },
        -- root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
      }

      require('jdtls').start_or_attach(config)
    end

    local augroup = vim.api.nvim_create_augroup('jdtls', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      group = augroup,
      callback = setup_jdtls,
    })
  end
}
