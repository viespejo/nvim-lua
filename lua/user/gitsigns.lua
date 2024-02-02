local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	cmd = "Gitsigns",
}

M.config = function()
	local icons = require("user.icons")

	require("gitsigns").setup({
		signs = {
			add = {
				hl = "GitSignsAdd",
				text = icons.ui.BoldLineMiddle,
				numhl = "GitSignsAddNr",
				linehl = "GitSignsAddLn",
			},
			change = {
				hl = "GitSignsChange",
				text = icons.ui.BoldLineDashedMiddle,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
			delete = {
				hl = "GitSignsDelete",
				text = icons.ui.TriangleShortArrowRight,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			topdelete = {
				hl = "GitSignsDelete",
				text = icons.ui.TriangleShortArrowRight,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = icons.ui.BoldLineMiddle,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		update_debounce = 200,
		max_file_length = 40000,
		preview_config = {
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next Hunk - GitSigns" })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Previous Hunk - GitSigns" })

			-- Actions
			map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk - GitSigns" })
			map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk - GitSigns" })
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage Hunk - GitSigns" })
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset Hunk - GitSigns" })
			map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer - GitSigns" })
			map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk - GitSigns" })
			map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer - GitSigns" })
			map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk - GitSigns" })
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "Blame Line - GitSigns" })
			map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Blame Line - GitSigns" })
			map("n", "<leader>hd", gs.diffthis, { desc = "Diff This - GitSigns" })
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end, { desc = "Diff This (cached) - GitSigns" })
			map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted - GitSigns" })

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
		end,
	})
end

return M
