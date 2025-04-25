return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	key = {
		vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" }),
	},
}
