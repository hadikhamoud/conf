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

-- return {
--   {
--     "0Risotto/rainbow12",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.cmd("colorscheme rainbow12")
--     end,
--   }
-- }

return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false,
			dimInactive = false,
			terminalColors = true,
			colors = {
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors)
				return {}
			end,
			theme = "wave",
			background = {
				dark = "wave",
				light = "lotus"
			},
		})
		vim.cmd("colorscheme kanagawa")
	end,
}
