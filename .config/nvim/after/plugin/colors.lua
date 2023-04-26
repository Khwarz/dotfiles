function ColorMyPencils(color)
	color = color or "github_dark_default"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
