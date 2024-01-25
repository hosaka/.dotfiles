local wezterm = require("wezterm")

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_domain = "WSL:Ubuntu"
config.window_close_confirmation = "NeverPrompt"

config.color_scheme = "Tokyo Night Moon"
config.enable_tab_bar = false
config.check_for_updates = false
-- config.term = "wezterm"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.font_size = 11.0
config.animation_fps = 30
config.underline_position = -2
config.default_cursor_style = "BlinkingBlock"

local font_features = {
	"calt", -- Contextual Alternatives (aka texture healing)
	"liga", -- Standard Ligatures
	"dlig", -- Discretionary Ligatures
	"ss01", -- Stylistic Sets (see https://github.com/githubnext/monaspace?tab=readme-ov-file#coding-ligatures)
	"ss02",
	"ss03",
	"ss04",
	"ss05",
	"ss06",
	"ss07",
	"ss08",
}

config.font = wezterm.font_with_fallback({
	{
		family = "Monaspace Neon",
		harfbuzz_features = font_features,
	},
})

config.font_rules = {
	{
		-- Italic
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = "Monaspace Radon",
			-- style = "Italic",
			weight = "Light",
			harfbuzz_features = font_features,
		}),
	},

	{
		-- Bold
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = "Monaspace Krypton",
			weight = "Bold",
			harfbuzz_features = font_features,
		}),
	},

	{
		-- Bold Italic
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "Monaspace Xenon",
			style = "Italic",
			weight = "Bold",
			harfbuzz_features = font_features,
		}),
	},
}

return config
