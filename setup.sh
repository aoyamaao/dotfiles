#!/bin/bash

# スクリプトがあるディレクトリの絶対パスを取得
DOT_DIR=$(cd $(dirname $0) && pwd)

echo "シンボリックリンクを作成します..."

# ln -sfv:
# -s: シンボリックリンクを作成
# -f: リンク先に同名のファイルやリンクが既に存在する場合は強制的に上書き
# -v: 実行内容を詳細に表示

# 各設定ファイルのシンボリックリンクを作成
ln -sfv "${DOT_DIR}/git/config" "${HOME}/.gitconfig"
ln -sfv "${DOT_DIR}/tmux/tmux.conf" "${HOME}/.tmux.conf"
ln -sfv "${DOT_DIR}/vim/vimrc" "${HOME}/.vimrc"
ln -sfv "${DOT_DIR}/zsh/zshrc" "${HOME}/.zshrc"
# .config配下
mkdir -p "${HOME}/.config"
rm -rf "${HOME}/.config/nvim" # ディレクトリなので一旦削除する
ln -sfv "${DOT_DIR}/nvim" "${HOME}/.config/nvim"
ln -sfv "${DOT_DIR}/alacritty/alacritty.toml" "${HOME}/.config/alacritty/alacritty.toml"

echo "セットアップが完了しました。"
