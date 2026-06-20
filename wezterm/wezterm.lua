local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Hiragino Sans",
})

config.color_scheme = "Tokyo Night Moon"
config.font_size = 16

config.window_frame = {
	font = wezterm.font("JetBrains Mono"),
	font_size = 16,
}

config.use_fancy_tab_bar = true

-- tmux連携
config.term = "wezterm"
config.set_environment_variables = {
	TERMINFO_DIRS = wezterm.home_dir .. "/.nix-profile/share/terminfo:/usr/share/terminfo",
}

return config
