return {
  "vague2k/vague.nvim",
  enabled = false,  -- using kanagawa instead
  lazy = false,
  priority = 1001, -- make sure to load this before all the other plugins
  config = function()
    vim.cmd.colorscheme("vague")
  end,
}
