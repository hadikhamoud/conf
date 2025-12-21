-- return {
-- 	"vague2k/vague.nvim",
-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other plugins
-- 	config = function()
-- 		vim.cmd([[colorscheme vague]])
-- 	end,
-- }

-- return {
-- 	"scottmckendry/cyberdream.nvim",
-- 	lazy = false,
-- 	priority = 900,
-- 	config = function()
-- 		require("cyberdream").setup({
-- 			-- Your Cyberdream configuration options here
-- 			-- For example:
-- 			transparent = false,
-- 			italic_comments = true,
-- 			hide_fillchars = true,
-- 			borderless_telescope = false,
-- 			theme = "default",
-- 		})
-- 		vim.cmd([[colorscheme cyberdream]])
-- 	end,
-- }

return {
  {
    "0Risotto/rainbow12",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme rainbow12")
    end,
  }
}
