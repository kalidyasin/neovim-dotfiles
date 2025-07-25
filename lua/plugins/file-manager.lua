return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	keys = {
		{
			"-",
			function()
				require("oil").open_float()
			end,
			desc = "Open parent directory",
		},
	},
}
