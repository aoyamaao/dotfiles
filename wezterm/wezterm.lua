local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

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

config.keys = {
	-- タブを閉じる
	{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
	-- タブ追加
	{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
	-- タブ切り替え
	{ key = "1", mods = "CMD", action = act.ActivateTabRelative(1) },
	-- ペインを閉じる
	{ key = "w", mods = "CMD|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },
	-- ペイン分割
	{ key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- ペイン拡張
	{ key = "z", mods = "CMD", action = act.TogglePaneZoomState },
	-- ペイン移動
	{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
}

-- tmux連携
config.term = "wezterm"
config.set_environment_variables = {
	TERMINFO_DIRS = wezterm.home_dir .. "/.nix-profile/share/terminfo:/usr/share/terminfo",
}

return config
