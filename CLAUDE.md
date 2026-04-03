# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 概要

macOS用のdotfilesリポジトリ。`~/.config`に直接クローンして使用する。シェル、ターミナル、エディタ、各種ツールの設定を管理。

## リポジトリ構成

- **nvim/** — Gitサブモジュール（別リポ: `ohikouta/nvim`）。更新は `cd nvim && git pull` → 親リポでサブモジュールポインタをコミット。
- **zsh/.zshrc** — メインのシェル設定。Oh My Zsh + コンテキストラベル付きカスタムプロンプト（WORK/OBSIDIAN/HOME/LOCAL）、tmux連携、ペイン自動色分け、codexワークスペース検出。
- **tmux/tmux.conf** — Vim式ナビゲーション、マウス対応、viコピーモード、動的ペインタイトル。
- **vim/vimrc** — 軽量なエディタ設定（基本は2スペースインデント、UTF-8、スワップファイル無効。markdownは `tabstop/shiftwidth=4` + `noexpandtab` で4幅ハードタブ）。
- **ghostty/config**, **wezterm/wezterm.lua** — ターミナルエミュレータ設定。
- **karabiner/** — キーボードリマッピング（スクリーンショットショートカット変更）。
- **gh/config.yml** — GitHub CLI設定（HTTPSプロトコル、`co`エイリアスで`pr checkout`）。
- **htop/htoprc** — システムモニター表示設定。

## 主要パターン

- **コンテキスト認識**: zshプロンプトとtmuxペインの色がディレクトリに応じて変化（work→緑、personal→青、dotfiles→黄、/tmp→赤）。
- **tmuxヘルパー関数（zsh内）**: `tsplit N`でペインをN分割＋自動色付け、`tpcolor`で手動色設定。
- **シンボリンク不要**: リポ自体が`~/.config`なのでsymlinkマネージャは不要。

## コミット規約

`<スコープ>: <説明>` の形式。スコープはツール名（例: `zsh:`, `tmux:`, `vim:`）。日本語の説明可。

## .gitignoreで除外されているもの

認証・ランタイム状態（`gh/hosts.yml`, `configstore/`, `iterm2/`）、自動バックアップ（`karabiner/automatic_backups/`）、未整理の設定（`anyenv/`, `fish/`, `raycast/`）。
