return {
	"kyazdani42/nvim-tree.lua",
	enabled = true,
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	lazy = false,
	keys = {
		{ "<leader>ff", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in filetree" },
		{ "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Find file in filetree" },
	},
	opts = {
		filters = {
			custom = { ".git", "node_modules", ".vscode", ".next", "dist", "build", "target", ".cargo", "venv", "data" },
			dotfiles = true,
			git_ignored = true,
		},
		git = {
			enable = false,
		},
		diagnostics = {
			enable = false,
		},
		filesystem_watchers = {
			enable = false,
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		renderer = {
			add_trailing = false,
			group_empty = false,
			highlight_git = false,
			full_name = false,
			highlight_opened_files = "none",
			root_folder_modifier = ":~",
			indent_width = 2,
			indent_markers = {
				enable = false,
			},
			icons = {
				webdev_colors = false,
				git_placement = "before",
				modified_placement = "after",
				padding = " ",
				symlink_arrow = " ➛ ",
				show = {
					file = false,
					folder = false,
					folder_arrow = false,
					git = false,
					modified = false,
				},
			},
		},
		view = {
			adaptive_size = true,
			centralize_selection = false,
			width = 30,
			preserve_window_proportions = false,
			number = false,
			relativenumber = false,
			signcolumn = "yes",
			float = {
				enable = true,
			},
		},
		update_focused_file = {
			enable = false,
		},
		hijack_cursor = false,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = false,
		sync_root_with_cwd = false,
		reload_on_bufenter = false,
		respect_buf_cwd = false,
		prefer_startup_root = false,
		disable_netrw = false,
	},
}
