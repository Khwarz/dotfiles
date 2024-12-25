local python_path = function()
  local cwd = vim.loop.cwd()
  if vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
    return cwd .. '/.venv/bin/python'
  else
    return '/usr/bin/python'
  end
end

return {
  {
    'mfussenegger/nvim-dap',
    optional = true,
    dependencies = {
      'mfussenegger/nvim-dap-python',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
    },
    keys = {
      {
        '<leader>dm',
        function()
          require('dap-python').test_method()
        end,
        desc = 'Debug Method',
      },
      {
        '<leader>dc',
        function()
          require('dap-python').test_class()
        end,
        desc = 'Debug Class',
      },
    },
    config = function()
      local dap, ui = require 'dap', require 'dapui'
      ui.setup()
      require('nvim-dap-virtual-text').setup()

      -- Python configuration
      require('dap-python').setup(python_path())
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = python_path(),
        },
        {
          type = 'python',
          request = 'launch',
          name = 'DAP Django',
          program = vim.loop.cwd() .. '/manage.py',
          args = { 'runserver', '--noreload' },
          justMyCode = true,
          django = true,
          console = 'integratedTerminal',
        },
        {
          type = 'python',
          request = 'attach',
          name = 'Attach remote',
          connect = function()
            return {
              host = '127.0.0.1',
              port = 5678,
            }
          end,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file with arguments',
          program = '${file}',
          args = function()
            local args_string = vim.fn.input 'Arguments: '
            return vim.split(args_string, ' +')
          end,
          console = 'integratedTerminal',
          pythonPath = python_path(),
        },
      }
      dap.adapters.python = {
        type = 'executable',
        command = python_path(),
        args = { '-m', 'debugpy.adapter' },
      }
      -- End of python configuration

      vim.keymap.set('n', '<leader>?', function()
        ui.eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<F1>', dap.continue)
      vim.keymap.set('n', '<F2>', dap.step_into)
      vim.keymap.set('n', '<F3>', dap.step_over)
      vim.keymap.set('n', '<F4>', dap.step_out)
      vim.keymap.set('n', '<F5>', dap.step_back)
      vim.keymap.set('n', '<F12>', dap.restart)

      vim.keymap.set('n', '<Leader>b', function()
        dap.toggle_breakpoint()
      end)
      vim.keymap.set('n', '<Leader>B', function()
        dap.set_breakpoint()
      end)
      vim.keymap.set('n', '<Leader>lp', function()
        dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end)
      vim.keymap.set('n', '<Leader>dr', function()
        dap.repl.open()
      end)
      vim.keymap.set('n', '<Leader>dl', function()
        dap.run_last()
      end)
      vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
        require('dap.ui.widgets').hover()
      end)
      vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
        require('dap.ui.widgets').preview()
      end)
      vim.keymap.set('n', '<Leader>df', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.frames)
      end)
      vim.keymap.set('n', '<Leader>ds', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.scopes)
      end)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   ui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   ui.close()
      -- end
    end,
  },
}
