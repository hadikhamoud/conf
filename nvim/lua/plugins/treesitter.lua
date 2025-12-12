return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- add this
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        ensure_installed = {
          "lua",
          "typescript",
          "tsx",
          "go",
          "python", -- add python here
          "zig", -- add python here
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer", -- whole function
              ["if"] = "@function.inner", -- inside function body
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 1,
    },
  },
}
