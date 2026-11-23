-- Make the relative line numbers readable.
-- Themes in the omarchy pipeline (e.g. aether) render LineNr/LineNrAbove/
-- LineNrBelow in a "muted" color that can sit almost exactly on the
-- background, which hides the numbers. Derive a foreground from the Normal
-- text color (pulled toward mid-gray) instead, and reapply on every
-- colorscheme load so theme switches keep the override.
local function blend(fg, other, t)
	local fr, fg2, fb = math.floor(fg / 65536) % 256, math.floor(fg / 256) % 256, fg % 256
	local or_, og, ob = math.floor(other / 65536) % 256, math.floor(other / 256) % 256, other % 256
	local function mix(a, b)
		return math.floor(a + (b - a) * t + 0.5)
	end
	return mix(fr, or_) * 65536 + mix(fg2, og) * 256 + mix(fb, ob)
end

local function apply()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	local readable = normal.fg and blend(normal.fg, 0x808080, 0.45) or 0x808080
	for _, group in ipairs({ "LineNr", "LineNrAbove", "LineNrBelow" }) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		hl.fg = readable
		vim.api.nvim_set_hl(0, group, hl)
	end
end

-- plugin/ files are sourced after the startup colorscheme is applied
apply()

-- Reapply on theme switches (including omarchy's hot-reload)
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("kingscott-linenr", { clear = true }),
	callback = apply,
})
