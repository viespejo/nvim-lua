local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
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

	local lsp_server = {
		-- Lsp server name .
		function()
			local msg = "No Active Lsp"
			local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
			local clients = vim.lsp.get_active_clients()
			if next(clients) == nil then
				return msg
			end

			local client_names = {}
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					-- add client name to the list
					table.insert(client_names, client.name)
				end
			end

			if next(client_names) ~= nil then
				local concatenated = table.concat(client_names, ", ")
				local max = 40
				-- trucate the string if it's too long
				if string.len(concatenated) > max then
					concatenated = string.sub(concatenated, 1, max) .. "..."
				end

				return concatenated
			end

			return msg
		end,
		icon = " LSP:",
		color = { fg = "#ffffff", gui = "bold" },
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
			-- lualine_b = { branch, diff, diagnostics },
			lualine_b = { branch, diagnostics },
			lualine_c = { "filename" },
			lualine_x = { lsp_server, "copilot", "encoding", { "fileformat", icons_enabled = false }, filetype },
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
			require("user.lualine-extensions.trouble"),
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
