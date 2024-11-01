local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
	update_interval = 5000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
		vim.cmd("colorscheme wildcharm")
	end,
	set_light_mode = function()
		vim.cmd([[
			try
				colorscheme github
			catch
				colorscheme default
			endtry
		]])
	end,
})
