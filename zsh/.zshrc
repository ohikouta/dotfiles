# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dpoggi"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# 改行なし出力末尾の % マークを非表示
unsetopt PROMPT_SP

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval "$(anyenv init -)"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

# Obsidian AI Agent Aliases
alias vp='cd "/Users/kota/Library/Mobile Documents/iCloud~md~obsidian/Documents" && claude'
alias vw='cd "/Users/kota/Desktop/work" && claude'

# Tmux
# ~/.zshrc に追加

# =============================================================
#  ペイン背景色パレット
# =============================================================
TSPLIT_COLORS=(
  "colour235"    # 濃いグレー
  "#1a2e1a"      # 濃緑
  "#2e1a1a"      # 濃赤
  "#2e2e1a"      # 濃黄
  "#1a2e2e"      # 濃シアン
  "#2e1a2e"      # 濃マゼンタ
)

# =============================================================
#  tsplit - 指定した枚数にペインを分割＋色分け
#
#  使い方:
#    tsplit 4           → 4分割 (tiled / 色分けあり)
#    tsplit 3 -h        → 3分割 (横並び)
#    tsplit 3 -v        → 3分割 (縦並び)
#    tsplit 4 --no-color → 色分けなし
# =============================================================
tsplit() {
  local count=${1:-2}
  local layout="tiled"
  local colorize=true

  for arg in "${@:2}"; do
    case "$arg" in
      -h) layout="even-horizontal" ;;
      -v) layout="even-vertical" ;;
      --no-color) colorize=false ;;
    esac
  done

  if [[ -z "$TMUX" ]]; then
    echo "Error: tmux session の中で実行してください"
    return 1
  fi
  if [[ "$count" -lt 2 ]]; then
    echo "Error: 2以上の数を指定してください"
    return 1
  fi

  for ((i = 1; i < count; i++)); do
    tmux split-window
    tmux select-layout "$layout"
  done

  if $colorize; then
    local idx=1
    local pane_list
    pane_list=("${(@f)$(tmux list-panes -F '#{pane_id}')}")
    for pane_id in "${pane_list[@]}"; do
      local color_idx=$(( ((idx - 1) % ${#TSPLIT_COLORS[@]}) + 1 ))
      tmux select-pane -t "$pane_id" -P "bg=${TSPLIT_COLORS[$color_idx]}" 2>/dev/null
      ((idx++))
    done
  fi
}

# =============================================================
#  tpcolor - 現在のペインの背景色を手動で変更
#
#  使い方:
#    tpcolor "#2e1a1a"   → 指定色に変更
#    tpcolor reset       → デフォルトに戻す
# =============================================================
tpcolor() {
  if [[ -z "$TMUX" ]]; then
    echo "Error: tmux session の中で実行してください"
    return 1
  fi
  if [[ "$1" == "reset" ]]; then
    tmux select-pane -P "default"
  else
    tmux select-pane -P "bg=${1:-#1a1a2e}"
  fi
}

# =============================================================
#  ディレクトリ連動 自動背景色
#
#  cd するたびに現在のパスを判定し、ペインの背景色を自動で変える。
#  下のテーブルを自分の環境に合わせて編集する。
#  パスは前方一致なので、サブディレクトリにも適用される。
#
#  優先度: 上に書いたものが優先（最初にマッチしたものを適用）
# =============================================================

# テーブル定義: "パターン|色" の配列
# ※ 連想配列だと順序が保証されないので、通常配列で順序制御する
TPANE_DIR_RULES=(
  "$HOME/work|#1a2e1a"          # 仕事 → 緑系
  "$HOME/personal|#1a1a2e"      # 個人 → 青系
  "$HOME/dotfiles|#2e2e1a"      # dotfiles → 黄系
  "/tmp|#2e1a1a"                # tmp → 赤系 (注意喚起)
  # 追加例:
  # "$HOME/projects/api|#2e1a2e"    # 特定プロジェクト → マゼンタ
  # "$HOME/.config|#1a2e2e"         # 設定ファイル → シアン
)

# デフォルト背景色 (どのルールにもマッチしなかった場合)
TPANE_DEFAULT_BG="default"

_tpane_auto_color() {
  [[ -z "$TMUX" ]] && return

  local dir="$PWD"
  local rule pattern color

  for rule in "${TPANE_DIR_RULES[@]}"; do
    pattern="${rule%%|*}"
    color="${rule##*|}"
    if [[ "$dir" == "$pattern"* ]]; then
      tmux select-pane -P "bg=$color" 2>/dev/null
      return
    fi
  done

  # どのルールにもマッチしなければデフォルト
  tmux select-pane -P "$TPANE_DEFAULT_BG" 2>/dev/null
}

# zsh: cd するたびに _tpane_auto_color を実行
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _tpane_auto_color

# シェル起動時にも現在のディレクトリで色を適用
_tpane_auto_color
