return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,  desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,           desc = "Continue" },
      { "<leader>do", function() require("dap").step_over() end,          desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end,          desc = "Step Into" },
      { "<leader>dO", function() require("dap").step_out() end,           desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.open() end,          desc = "Open REPL" },
      { "<leader>dl", function() require("dap").run_last() end,           desc = "Run Last" },
      { "<leader>dt", function() require("dapui").toggle() end,           desc = "Toggle DAP UI" },
      { "<leader>dB", function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, desc = "Conditional Breakpoint" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Automatically open/close dap-ui when debugging starts/stops
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Auto-detect virtualenv: checks VIRTUAL_ENV, then common venv dirs, falls back to system python3
      local function get_python_path()
        -- 1. Active virtualenv (if you activated it before opening nvim)
        if vim.env.VIRTUAL_ENV then
          return vim.env.VIRTUAL_ENV .. "/bin/python"
        end

        -- 2. Common venv directories relative to the project root
        local cwd = vim.fn.getcwd()
        local venv_dirs = { "venv", ".venv", "env", ".env" }
        for _, dir in ipairs(venv_dirs) do
          local path = cwd .. "/" .. dir .. "/bin/python"
          if vim.fn.executable(path) == 1 then
            return path
          end
        end

        -- 3. Fallback to system python
        return "python3"
      end

      local python_path = get_python_path()
      require("dap-python").setup(python_path)

      -- Custom configuration: run a specific file (e.g. test.py)
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Launch specific file",
        program = function()
          return vim.fn.input("File path: ", vim.fn.getcwd() .. "/", "file")
        end,
        pythonPath = python_path,
      })
    end,
  },
}
