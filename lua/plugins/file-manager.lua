return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
			win_options = {
				signcolumn = "yes:2",
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
				["<M-h>"] = "actions.select_split",
				["q"] = "actions.close",
			},
			skip_confirm_for_simple_edits = true,
		},
		dependencies = {
			{
				"nvim-mini/mini.icons",
				opts = {},
			},
		},
		keys = {
			{
				"-",
				function()
					require("oil").toggle_float()
				end,
				desc = "Open parent directory in float window",
			},
		},
	},
	{
		"refractalize/oil-git-status.nvim",
		event = "VeryLazy",
		dependencies = {
			"stevearc/oil.nvim",
		},
		opts = {},
	},
	{
		"benomahony/oil-git.nvim",
		event = "VeryLazy",
		dependencies = { "stevearc/oil.nvim" },
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		event = "VeryLazy",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
}
