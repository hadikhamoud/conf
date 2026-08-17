return {
	"hadikhamoud/hover-rtl.nvim",
	event = "LspAttach",
	config = function()
		require("hover-rtl").setup({
			enabled = true,
			border = "rounded",
			highlight = "NormalFloat",
		})
	end,
}
