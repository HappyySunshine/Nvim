function Colorize(color)
	color = color or "tokyonight"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd('highlight LineNr guifg=#42b4fc')

	-- vim.cmd([[highlight LineNr ctermfg=#ffec1e guifg=green ctermbg=none guibg=none]])
	vim.cmd([[highlight SignColumn guibg=none]])
end

Colorize()
