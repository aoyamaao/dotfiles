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

-- Ctrl+hjklでペイン移動するヘルパー
local function is_passthrough(pane)
	if pane:get_user_vars().IS_NVIM == "true" then
		return true
	end
	local p = pane:get_foreground_process_name() or ""
	p = p:match("([^/\\]+)$") or p
	return p == "tmux"
end

local dir = { h = "Left", j = "Down", k = "Up", l = "Right" }

local function ctrl_move(key)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_passthrough(pane) then
				win:perform_action({ SendKey = { key = key, mods = "CTRL" } }, pane)
			else
				win:perform_action({ ActivatePaneDirection = dir[key] }, pane)
			end
		end),
	}
end

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
	ctrl_move("h"),
	ctrl_move("j"),
	ctrl_move("k"),
	ctrl_move("l"),
	-- コピーモード起動
	{ key = "Enter", mods = "CMD", action = act.ActivateCopyMode },
}

-- コピーモードでCtrl+[をEsc相当にする
local copy_mode = wezterm.gui.default_key_tables().copy_mode
table.insert(copy_mode, {
	key = "[",
	mods = "CTRL",
	action = act.CopyMode("Close"),
})
config.key_tables = {
	copy_mode = copy_mode,
}

-- tmux連携
config.term = "wezterm"
config.set_environment_variables = {
	TERMINFO_DIRS = wezterm.home_dir .. "/.nix-profile/share/terminfo:/usr/share/terminfo",
}

return config
