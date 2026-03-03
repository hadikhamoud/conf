return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    main = "nvim-treesitter.configs",
    opts = {
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 50 * 1024 -- 50 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
          local line_count = vim.api.nvim_buf_line_count(buf)
          if line_count > 5000 then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      ensure_installed = {
        "lua",
        "typescript",
        "tsx",
        "go",
        "python",
        "zig",
      },
      indent = {
        enable = true,
        disable = { "python" },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
          },
        },
      },
    },
  },
}
