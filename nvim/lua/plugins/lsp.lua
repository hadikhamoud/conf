return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig_defaults = require("lspconfig").util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig_defaults.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          vim.keymap.set(
            "n",
            "<leader>vd",
            "<cmd>lua vim.diagnostic.open_float()<cr>",
            { desc = "View Diagnostics" }
          )
          vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
          vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        end,
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "astro",
          "cssls",
          "vtsls",
          "cssmodules_ls",
          "gopls",
          "lua_ls",
          "pyright",
          "ruff",
        },
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({})
          end,
          ["vtsls"] = function()
            require("lspconfig").vtsls.setup({
              root_dir = require("lspconfig").util.root_pattern(
                ".git",
                "pnpm-workspace.yaml",
                "pnpm-lock.yaml",
                "yarn.lock",
                "package-lock.json",
                "bun.lockb"
              ),
              typescript = {
                tsserver = {
                  maxTsServerMemory = 12288,
                },
              },
              experimental = {
                completion = {
                  entriesLimit = 3,
                },
              },
            })
          end,
          ["pyright"] = function()
            require("lspconfig").pyright.setup({
              root_dir = require("lspconfig").util.root_pattern(
                ".git",
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "Pipfile",
                "pyrightconfig.json"
              ),
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                    autoImportCompletions = true,
                  },
                  pythonPath = vim.fn.exepath("python3") or vim.fn.exepath("python"),
                },
              },
              before_init = function(_, config)
                -- Auto-detect virtual environment
                local util = require("lspconfig.util")
                local path = util.path
                
                -- Check for common venv patterns
                local venv_paths = {
                  path.join(config.root_dir, "venv", "bin", "python"),
                  path.join(config.root_dir, ".venv", "bin", "python"),
                  path.join(config.root_dir, "env", "bin", "python"),
                  path.join(config.root_dir, ".env", "bin", "python"),
                }
                
                -- Check VIRTUAL_ENV environment variable
                local virtual_env = os.getenv("VIRTUAL_ENV")
                if virtual_env then
                  table.insert(venv_paths, 1, path.join(virtual_env, "bin", "python"))
                end
                
                -- Use the first valid python path found
                for _, python_path in ipairs(venv_paths) do
                  if vim.fn.executable(python_path) == 1 then
                    config.settings.python.pythonPath = python_path
                    break
                  end
                end
              end,
            })
          end,
          ["ruff"] = function()
            require("lspconfig").ruff.setup({
              root_dir = require("lspconfig").util.root_pattern(
                ".git",
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "Pipfile"
              ),
            })
          end,
          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              root_dir = require("lspconfig").util.root_pattern(
                "go.mod",
                "go.work",
                ".git"
              ),
              settings = {
                gopls = {
                  analyses = {
                    unusedparams = true,
                    shadow = true,
                  },
                  staticcheck = true,
                  gofumpt = true,
                  usePlaceholders = true,
                  completeUnimported = true,
                  experimentalPostfixCompletions = true,
                  hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Insert }
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping.select_next_item({ behaviour = cmp.SelectBehavior.Insert }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behaviour = cmp.SelectBehavior.Insert }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },
}
