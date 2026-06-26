#!/bin/bash
#
# macOSのキーボード設定を適用する
# 反映には再ログインまたは再起動が必要

set -euo pipefail

echo "現在の設定:"
echo "  KeyRepeat:                $(defaults read -g KeyRepeat 2>/dev/null || echo '(未設定)')"
echo "  InitialKeyRepeat:         $(defaults read -g InitialKeyRepeat 2>/dev/null || echo '(未設定)')"
echo "  ApplePressAndHoldEnabled: $(defaults read -g ApplePressAndHoldEnabled 2>/dev/null || echo '(未設定)')"
echo

# リピート間隔 (15ms単位)
# GUIスライダー最速は2 (30ms間隔)、1で限界突破 (15ms間隔 ≒ 66回/秒)
defaults write -g KeyRepeat -int 1

# リピート開始までの遅延 (15ms単位)
# GUIスライダー最短は15 (225ms)、10で限界突破 (150ms)
defaults write -g InitialKeyRepeat -int 15

# 長押しでの特殊文字メニューを無効化してキーリピートを有効にする
# これが有効だと一部キー(a/e/i/o/u等)でリピートが効かなくなる
defaults write -g ApplePressAndHoldEnabled -bool false

echo "適用後の設定:"
echo "  KeyRepeat:                $(defaults read -g KeyRepeat)"
echo "  InitialKeyRepeat:         $(defaults read -g InitialKeyRepeat)"
echo "  ApplePressAndHoldEnabled: $(defaults read -g ApplePressAndHoldEnabled)"
echo
echo "完了。再ログインまたは再起動で反映されます。"
