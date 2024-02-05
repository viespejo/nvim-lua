local M = {
	"mfussenegger/nvim-dap",
	lazy = true,
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
	},
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
		},
	},
}
function M.config()
	local dapui = require("dapui")
	dapui.setup()

	local dap = require("dap")
	local widgets = require("dap.ui.widgets")

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({ reset = true })
	end
	dap.listeners.before.event_terminated["dapui_config"] = dapui.close
	dap.listeners.before.event_exited["dapui_config"] = dapui.close

	-- dap virtual text
	require("nvim-dap-virtual-text").setup({
		enabled = true, -- enable this plugin (the default)
		enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
		highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
		highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
		show_stop_reason = true, -- show stop reason when stopped for exceptions
		commented = true, -- prefix virtual text with comment string
		-- experimental features:
		virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
		all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
		virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
		virt_text_win_col = 80, -- position the virtual text at a fixed window column (starting from the first text column) ,
		-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
	})

	local opts = { noremap = true, silent = true }
	local keymap = vim.keymap.set

	keymap("n", "<leader>ds", function()
		dap.disconnect()
	end, opts)
	keymap("n", "<leader>dk", function()
		dap.up()
	end, opts)
	keymap("n", "<leader>dj", function()
		dap.down()
	end, opts)
	keymap("n", "<leader>dn", function()
		dap.step_over()
	end, opts)
	keymap("n", "<leader>di", function()
		dap.step_into()
	end, opts)
	keymap("n", "<leader>do", function()
		dap.step_out()
	end, opts)
	keymap("n", "<leader>dg", function()
		dap.run_to_cursor()
	end, opts)
	keymap("n", "<leader>dB", function()
		dap.set_breakpoin()
	end, opts)
	-- keymap("n", "<leader>dr", function()
	-- 	dap.repl.toggle({ height = 15 })
	-- end, opts)
	-- keymap("n", "<leader>d/", function()
	-- 	local sidebar = widgets.sidebar(widgets.scopes)
	-- 	sidebar.toggle()
	-- end, opts)
	keymap({ "n", "v" }, "<leader>de", function()
		dapui.eval()
	end, opts)
	keymap("n", "<leader>dv", function()
		widgets.centered_float(widgets.scopes)
	end, opts)
	keymap("n", "<leader>dl", ":DapVirtualTextForceRefresh<CR>", opts)

	-- see adapters in ftplugin
end

return M
