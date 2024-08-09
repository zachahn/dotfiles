local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
	update_interval = 5000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
		vim.cmd("colorscheme wildcharm")
	end,
	set_light_mode = function()
		vim.api.nvim_set_option('background', 'light')
		vim.cmd("execute 'try \n colorscheme github \n catch colorscheme default \n endtry'")
	end,
})
