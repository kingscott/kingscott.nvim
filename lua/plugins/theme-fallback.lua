-- Fallback colorscheme for machines without Omarchy.
-- lua/plugins/theme.lua is a symlink into ~/.local/state/omarchy, which only
-- exists on Omarchy machines. Where it doesn't resolve, fall back to
-- kanagawa-dragon instead of LazyVim's default (tokyonight-moon).
-- On Omarchy machines the symlink resolves, this returns nothing, and the
-- Omarchy theme wins.
local omarchy_theme = vim.fn.stdpath("config") .. "/lua/plugins/theme.lua"

if vim.uv.fs_realpath(omarchy_theme) ~= nil then
	return {}
end

return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "kanagawa-dragon",
		},
	},
}
