return {
	"hadikhamoud/hover-rtl.nvim",
	config = function()
		require("hover-rtl").setup({
			enabled = true,
			border = "rounded",
			highlight = "NormalFloat",
		})
	end,
}
