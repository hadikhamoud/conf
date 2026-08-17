return {
  -- Mason loaded lazily - only when you run :Mason
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function setup(server, opts)
        opts = opts or {}
        opts.capabilities = vim.tbl_deep_extend(
          "force",
          {},
          default_capabilities,
          opts.capabilities or {}
        )
        vim.lsp.config(server, opts)
        vim.lsp.enable(server)
      end
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local supports = function(method)
            return client and client:supports_method(method)
          end

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          if supports("textDocument/definition") then
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          end
          if supports("textDocument/declaration") then
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          end
          if supports("textDocument/implementation") then
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          end
          if supports("textDocument/references") then
            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          end
          if supports("textDocument/signatureHelp") then
            vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          end
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

      -- Ruff for Python (linting, formatting)
      setup("ruff")

      -- Pyright for Python navigation/completion (kept lightweight)
      setup("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              diagnosticMode = "openFilesOnly",
              autoImportCompletions = false,
            },
          },
        },
      })

      -- ty disabled for now - causes slow quit
      -- setup("ty")

      setup("lua_ls")

      setup("rust_analyzer", {
        root_markers = { "Cargo.toml", "rust-project.json", ".git" },
      })

      setup("gopls", {
        root_markers = { "go.mod", "go.work", ".git" },
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      })

      setup("vtsls", {
        root_markers = {
          ".git",
          "pnpm-workspace.yaml",
          "package-lock.json",
        },
      })

      setup("zls")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
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
