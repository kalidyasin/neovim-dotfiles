return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "main", 
	commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
	version = false,
	build = ":TSUpdate",
	event = { "VeryLazy" },
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall", "TSInstallInfo" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function(_, opts)
		local ts = require("nvim-treesitter")

		-- Pre-install core languages explicitly defined
		if opts.ensure_installed then
			ts.install(opts.ensure_installed)
		end

		-- Custom filetype rules (e.g., Laravel Blade templates)
		vim.filetype.add({
			pattern = {
				[".*%.blade%.php"] = "blade",
			},
		})

		-- GET ALL AVAILABLE PARSERS
		local available_parsers = ts.get_available()

		-- DYNAMIC AUTO-INSTALL & ATTACH LOOP (Matches Kickstart logic)
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user_treesitter_auto_install", { clear = true }),
			callback = function(args)
				local buf, filetype = args.buf, args.match
				local language = vim.treesitter.language.get_lang(filetype)
				if not language then return end

				local installed_parsers = ts.get_installed("parsers") or {}

				if vim.tbl_contains(installed_parsers, language) then
					-- Case 1: Already installed -> Attach immediately
					vim.treesitter.start(buf, language)
				elseif vim.tbl_contains(available_parsers, language) then
					-- Case 2: Missing but supported -> Download in background, then attach
					ts.install(language):await(function()
						vim.schedule(function()
							if vim.api.nvim_buf_is_valid(buf) then
								vim.treesitter.start(buf, language)
							end
						end)
					end)
				end
			end,
		})
	end,
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"rust",
			"regex",
			"php",
			"blade",
			"json",
			"yaml",
			"css",
			"dockerfile",
			"javascript",
			"typescript",
			"tsx",
		},
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<M-space>",
				node_incremental = "<M-space>",
				scope_incremental = false,
				node_decremental = "<Backspace>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
					["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
					["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>xs"] = {
						query = "@parameter.inner",
						desc = "Swap the node under the cursor with the next",
					},
				},
				swap_previous = {
					["<leader>xS"] = {
						query = "@parameter.inner",
						desc = "swap the node under the cursor with the previous",
					},
				},
			},
		},
	},
}
