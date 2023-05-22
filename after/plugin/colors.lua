function Colorize(color)
	color = color or "oxocarbon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

    vim.cmd([[highlight LineNr ctermfg=yellow guifg=yellow ctermbg=none guibg=none]])
    vim.cmd([[highlight SignColumn guibg=none]])
end

Colorize()
