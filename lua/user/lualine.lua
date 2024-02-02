local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"AndreM222/copilot-lualine",
	},
}

function M.config()
	local hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end

	local diff = {
		"diff",
		-- colored = false,
		-- symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
		cond = hide_in_width,
	}

	local diagnostics = {
		"diagnostics",
		-- sources = { "nvim_diagnostic" },
		-- sections = { "error", "warn" },
		symbols = { error = " ", warn = " " },
		colored = false,
		update_in_insert = false,
		cond = hide_in_width,
		-- always_visible = true,
	}

	local filetype = {
		function()
			local filetype = vim.bo.filetype
			local upper_case_filetypes = {
				"json",
				"jsonc",
				"yaml",
				"toml",
				"css",
				"scss",
				"html",
				"xml",
			}

			if vim.tbl_contains(upper_case_filetypes, filetype) then
				return filetype:upper()
			end

			return filetype
		end,
	}

	local branch = {
		"branch",
		-- icons_enabled = true,
		icon = "",
	}

	local mode = {
		"mode",
		fmt = function(str)
			return "-- " .. str .. " --"
		end,
	}

	require("lualine").setup({
		options = {
			theme = "tokyonight",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			-- disabled_filetypes = { "NvimTree" },
			-- ignore_focus = { "NvimTree" },
		},
		sections = {
			lualine_a = { mode },
			lualine_b = { branch, diff, diagnostics },
			lualine_c = { "filename" },
			lualine_x = { "copilot", "encoding", { "fileformat", icons_enabled = false }, filetype },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		extensions = {
			"quickfix",
			"man",
			"fugitive",
			"oil",
			require("user.lualine-extensions.fzf"),
			require("user.lualine-extensions.nvimtree"),
			"trouble",
			"mason",
			"lazy",
			"aerial",
			"nvim-dap-ui",
			"toggleterm",
		},
	})
end

return M
