---@diagnostic disable: missing-fields
-- Treesetter is feature that provides better syntax highlighting, indentation, autotagging, incremental selection and many other cool features.
return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- Import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ --enable syntax highlight
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable auto-tagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"lua",
				"vim",
				"vimdoc",
				"gitignore",
				"yaml",
				"markdown",
				"python",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
