return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- optional defaults; tweak as you like
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged_enable = true,
		current_line_blame = false, -- you can toggle it
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
			use_focus = true,
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, lhs, rhs, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end)
			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end)

			-- Actions
			map("n", "<leader>hs", gs.stage_hunk)
			map("n", "<leader>hr", gs.reset_hunk)
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("n", "<leader>hS", gs.stage_buffer)
			map("n", "<leader>hR", gs.reset_buffer)
			map("n", "<leader>hp", gs.preview_hunk)
			map("n", "<leader>hi", gs.preview_hunk_inline)

			-- Blame line (full popup)
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end)

			-- Diff
			map("n", "<leader>hd", gs.diffthis)
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end)

			-- Toggles
			map("n", "<leader>tb", gs.toggle_current_line_blame)
			map("n", "<leader>tw", gs.toggle_word_diff)

			-- Text object
			map({ "o", "x" }, "ih", gs.select_hunk)
		end,
	},
}
