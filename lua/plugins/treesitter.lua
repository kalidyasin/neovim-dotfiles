return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
		config = function()
			-- Ensure basic parsers are installed
			local parsers = {
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
			}
			require("nvim-treesitter").install(parsers)

			---@param buf integer
			---@param language string
			local function treesitter_try_attach(buf, language)
				-- Check if a parser exists and load it
				if not vim.treesitter.language.add(language) then
					return
				end
				-- Enable syntax highlighting and other treesitter features
				vim.treesitter.start(buf, language)

				-- Enable treesitter based folds
				-- For more info on folds see `:help folds`
				-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				-- vim.wo.foldmethod = 'expr'

				-- Check if treesitter indentation is available for this language, and if so enable it
				-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
				local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

				-- Enable treesitter based indentation
				if has_indent_query then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end

			local available_parsers = require("nvim-treesitter").get_available()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					local installed_parsers = require("nvim-treesitter").get_installed("parsers")

					if vim.tbl_contains(installed_parsers, language) then
						-- Enable the parser if it is already installed
						treesitter_try_attach(buf, language)
					elseif vim.tbl_contains(available_parsers, language) then
						-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
						require("nvim-treesitter").install(language):await(function()
							treesitter_try_attach(buf, language)
						end)
					else
						-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
						treesitter_try_attach(buf, language)
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		init = function()
			-- Disable entire built-in ftplugin mappings to avoid conflicts.
			-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
			vim.g.no_plugin_maps = true
		end,
		keys = {
			{"af", function() require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects") end, mode = { "x", "o" }, desc = "Select outer function" },
            {"if", function () require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")  end, mode = { "x", "o" }, desc = "Select inner function" },
            {"ac", function () require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")  end, mode = { "x", "o" }, desc = "Select outer class" },
            {"ic", function () require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")  end, mode = { "x", "o" }, desc = "Select inner class" },
			{"<leader>xs", function () require "nvim-treesitter-textobjects.swap".swap_next "@parameter.inner" end, mode = "n", desc = "Swap next parameter" },
            {"<leader>xS", function () require "nvim-treesitter-textobjects.swap".swap_previous "@parameter.outer" end, mode = "n", desc = "Swap previous parameter" },
        },
	},
}
