return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	lazy = false,
	opts = {
		logging = {
			enabled = false,
		},
	},
	keys = {
		{ "<C-p>", function() require("fff").find_in_git_root() end, desc = "Find files" },
		{ "<leader>fa", function() require("fff").find_files() end, desc = "Find all files" },
		{ "<leader>fi", function() require("fff").live_grep() end, desc = "Find in files" },
	},
}
