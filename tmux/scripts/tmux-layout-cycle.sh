#!/usr/bin/env bash
#
# tmux-layout-cycle.sh
#
# 定義済みのレイアウト群を、次に進める(巡回)か、インデックスで直接指定して
# 現在のウィンドウに適用する。
#
# Usage:
#   tmux-layout-cycle.sh           # 次のレイアウトへ進む(巡回)
#   tmux-layout-cycle.sh <index>   # 指定インデックス(0始まり)のレイアウトに切り替える
#
# Example .tmux.conf:
#   # F1: レイアウト0番(左右分割)に直接切り替え
#   bind-key F1 run-shell "~/dotfiles/tmux/scripts/tmux-layout-cycle.sh 0"
#
#   # F2: レイアウト1番(3列)に直接切り替え
#   bind-key F2 run-shell "~/dotfiles/tmux/scripts/tmux-layout-cycle.sh 1"
#
#   # Prefix + Space: 0 → 1 → 0 ... と巡回
#   bind-key Space run-shell "~/dotfiles/tmux/scripts/tmux-layout-cycle.sh"
#
# 注意:
#   select-layoutは「既存ペインの位置とサイズを並べ替える」だけで、ペインの新規作成・削除はしない。
#   レイアウト文字列のペイン数と、現在のウィンドウのペイン数が一致している必要がある。
#   下のLAYOUTSはいずれも4ペイン構成。

# set -e は使わない。
# 算術式 $((...))の結果が0だとbashは終了コード1を返し、set -eで誤って終了するため。
set -u

# 巡回対象のレイアウト文字列。インデックス順に並べる。
# 0: 4ペイン構成 — 左右に分割、それぞれ上下(上=薄/下=広)
# 1: 4ペイン構成 — 左単独 / 中単独 / 右(上=薄/下=広)
LAYOUTS=(
  "9988,314x72,0,0{157x72,0,0[157x6,0,0,123,157x65,0,7,126],156x72,158,0[156x6,158,0,124,156x65,158,7,125]}"
  "f03f,314x72,0,0{62x72,0,0[62x11,0,0,127,62x60,0,12,130],251x72,63,0[251x61,63,0,128,251x10,63,62,131]}"
)
OPTION_KEY="@layout-cycle-index"

ARG=${1:-}

if [ -n "$ARG" ]; then
  # 直接指定モード: 引数で渡されたインデックスのレイアウトに切り替える
  if ! [[ "$ARG" =~ ^[0-9]+$ ]] || [ "$ARG" -ge "${#LAYOUTS[@]}" ]; then
    echo "Invalid index: $ARG (valid: 0..$((${#LAYOUTS[@]} - 1)))" >&2
    exit 1
  fi
  NEXT=$ARG
else
  # 巡回モード: 現在位置の次に進む
  CURRENT=$(tmux show-option -gqv "$OPTION_KEY" 2>/dev/null)
  CURRENT=${CURRENT:--1}
  NEXT=$(( (CURRENT + 1) % ${#LAYOUTS[@]} ))
fi

# レイアウトを適用。失敗時はステータスバー(5秒表示)とstderrに詳細を出す
ERROR_OUTPUT=$(tmux select-layout "${LAYOUTS[$NEXT]}" 2>&1)
SELECT_RC=$?

if [ "$SELECT_RC" -ne 0 ]; then
  CURRENT_PANES=$(tmux list-panes | wc -l | tr -d ' ')
  MSG="layout switch failed (target index $NEXT, current panes $CURRENT_PANES). tmux: ${ERROR_OUTPUT:-no message}"
  # -dはミリ秒指定の表示時間。tmux 3.2以降で利用可能
  tmux display-message -d 5000 "$MSG" 2>/dev/null || tmux display-message "$MSG"
  echo "$MSG" >&2
  exit 1
fi

# 現在位置を保存(直接指定の場合もここを更新するので、次の巡回がそこから続く)
tmux set-option -g "$OPTION_KEY" "$NEXT"
