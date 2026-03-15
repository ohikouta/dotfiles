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
ZSH_THEME=""

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
plugins=(git)

for plugin in zsh-syntax-highlighting zsh-autosuggestions; do
    if [[ -d "${ZSH_CUSTOM:-$ZSH/custom}/plugins/${plugin}" ]] || [[ -d "${ZSH}/plugins/${plugin}" ]]; then
        plugins+=("${plugin}")
    fi
done

source $ZSH/oh-my-zsh.sh

# 改行なし出力末尾の % マークを非表示
unsetopt PROMPT_SP
setopt PROMPT_SUBST

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
if command -v anyenv >/dev/null 2>&1; then
    eval "$(anyenv init -)"
fi
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

typeset -g PROMPT_LAST_STATUS=0
typeset -g PROMPT_CMD_START=0
typeset -g PROMPT_CMD_DURATION=""

_prompt_context_accent() {
    case "$PWD" in
        "$HOME/Desktop/work"(|/*))
            echo "24"
            ;;
        "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"(|/*))
            echo "58"
            ;;
        "$HOME"(|/*))
            echo "150"
            ;;
        *)
            echo "238"
            ;;
    esac
}

_prompt_context_fg() {
    case "$PWD" in
        "$HOME/Desktop/work"(|/*))
            echo "231"
            ;;
        "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"(|/*))
            echo "231"
            ;;
        "$HOME"(|/*))
            echo "16"
            ;;
        *)
            echo "255"
            ;;
    esac
}

_prompt_path_label() {
    case "$PWD" in
        "$HOME/Desktop/work"(|/*))
            echo "WORK"
            ;;
        "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"(|/*))
            echo "OBSIDIAN"
            ;;
        "$HOME"(|/*))
            echo "HOME"
            ;;
        *)
            echo "LOCAL"
            ;;
    esac
}

_prompt_segment() {
    local fg="$1"
    local bg="$2"
    local text="$3"

    [[ -z "$text" ]] && return
    printf '%%K{%s}%%F{%s} %s %%f%%k' "$bg" "$fg" "$text"
}

_prompt_session_segment() {
    if [[ -n "$SSH_CONNECTION" ]]; then
        _prompt_segment "231" "60" "ssh %n@%m"
        return
    fi

    if [[ -n "$TMUX" ]]; then
        local tmux_session
        tmux_session=$(tmux display-message -p '#S' 2>/dev/null) || return
        _prompt_segment "16" "153" "tmux ${tmux_session}"
    fi
}

_prompt_runtime_segment() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        _prompt_segment "16" "114" "venv ${VIRTUAL_ENV:t}"
        return
    fi

    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        _prompt_segment "16" "114" "conda ${CONDA_DEFAULT_ENV}"
        return
    fi

    if [[ -n "$NIX_SHELL" ]]; then
        _prompt_segment "16" "180" "nix ${NIX_SHELL}"
    fi
}

_prompt_in_codex_workspace() {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/AGENTS.md" ]]; then
            return 0
        fi
        dir="${dir:h}"
    done

    return 1
}

_prompt_codex_name() {
    if [[ -n "$CODEX_NAME" ]]; then
        echo "$CODEX_NAME"
        return
    fi

    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/.codex-name" ]]; then
            local name
            name=$(<"$dir/.codex-name")
            name="${name%%$'\n'*}"
            [[ -n "$name" ]] && echo "$name"
            return
        fi
        dir="${dir:h}"
    done
}

_prompt_codex_segment() {
    [[ -n "$CODEX_THREAD_ID" || -n "$CODEX_CI" ]] || _prompt_in_codex_workspace || return
    local codex_name
    codex_name="$(_prompt_codex_name)"

    if [[ -n "$codex_name" ]]; then
        _prompt_segment "16" "45" "codex:${codex_name}"
        return
    fi

    _prompt_segment "16" "45" "codex"
}

_prompt_git_segment() {
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

    local branch dirty
    branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null || command git rev-parse --short HEAD 2>/dev/null) || return

    if [[ -n "$(command git status --porcelain --ignore-submodules=dirty 2>/dev/null)" ]]; then
        dirty=" !"
    fi

    _prompt_segment "231" "61" "git ${branch}${dirty}"
}

_prompt_status_segment() {
    (( PROMPT_LAST_STATUS == 0 )) && return
    _prompt_segment "231" "160" "exit ${PROMPT_LAST_STATUS}"
}

_prompt_duration_segment() {
    [[ -z "$PROMPT_CMD_DURATION" ]] && return
    _prompt_segment "16" "179" "${PROMPT_CMD_DURATION}"
}

_prompt_permission_segment() {
    [[ -w "$PWD" ]] && return
    _prompt_segment "231" "124" "read-only"
}

_prompt_time_segment() {
    _prompt_segment "16" "117" "%*"
}

_prompt_line_one() {
    local accent context_fg label session_segment path_segment git_segment codex_segment runtime_segment permission_segment status_segment duration_segment time_segment
    accent="$(_prompt_context_accent)"
    context_fg="$(_prompt_context_fg)"
    label="$(_prompt_path_label)"
    session_segment="$(_prompt_session_segment)"
    path_segment="$(_prompt_segment "$context_fg" "$accent" "$label %~")"
    git_segment="$(_prompt_git_segment)"
    codex_segment="$(_prompt_codex_segment)"
    runtime_segment="$(_prompt_runtime_segment)"
    permission_segment="$(_prompt_permission_segment)"
    status_segment="$(_prompt_status_segment)"
    duration_segment="$(_prompt_duration_segment)"
    time_segment="$(_prompt_time_segment)"

    echo "╭─${session_segment}${path_segment}${git_segment}${codex_segment}${runtime_segment}${permission_segment}${status_segment}${duration_segment}${time_segment}"
}

_prompt_line_two() {
    local caret_color="81"
    (( PROMPT_LAST_STATUS == 0 )) || caret_color="196"
    printf '╰─%%F{%s}❯%%f ' "$caret_color"
}

_prompt_precmd() {
    local exit_code=$?
    PROMPT_LAST_STATUS=$exit_code

    if (( PROMPT_CMD_START > 0 )); then
        local elapsed=$(( EPOCHSECONDS - PROMPT_CMD_START ))
        if (( elapsed >= 60 )); then
            PROMPT_CMD_DURATION="$(( elapsed / 60 ))m$(( elapsed % 60 ))s"
        elif (( elapsed >= 1 )); then
            PROMPT_CMD_DURATION="${elapsed}s"
        else
            PROMPT_CMD_DURATION=""
        fi
    else
        PROMPT_CMD_DURATION=""
    fi

    PROMPT_CMD_START=0
}

_prompt_preexec() {
    PROMPT_CMD_START=$EPOCHSECONDS
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_precmd
add-zsh-hook preexec _prompt_preexec

PROMPT='$(_prompt_line_one)
$(_prompt_line_two)'
RPROMPT=

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

# Obsidian AI Agent Aliases
alias vp='cd "/Users/kota/Library/Mobile Documents/iCloud~md~obsidian/Documents" && claude'
alias vw='cd "/Users/kota/Desktop/work" && claude'

if [[ -n "$TMUX" ]]; then
    function _tmux_path_style_for_pwd() {
        case "$PWD" in
            "$HOME/Desktop/work"(|/*))
                echo "#[fg=colour230,bg=colour24]"
                ;;
            "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"(|/*))
                echo "#[fg=colour230,bg=colour58]"
                ;;
            "$HOME"(|/*))
                echo "#[fg=colour16,bg=colour150]"
                ;;
            *)
                echo "#[fg=colour252,bg=colour238]"
                ;;
        esac
    }

    function _tmux_path_label_for_pwd() {
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
            print -P "%~"
            return
        fi

        case "$PWD" in
            "$HOME/Desktop/work"(|/*))
                echo "work ${PWD:t}"
                ;;
            "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"(|/*))
                echo "obsidian ${PWD:t}"
                ;;
            "$HOME"(|/*))
                echo "home ${PWD:t}"
                ;;
            *)
                echo "${PWD:t}"
                ;;
        esac
    }

    function _tmux_git_label() {
        command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

        local branch dirty
        branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null || command git rev-parse --short HEAD 2>/dev/null) || return

        if [[ -n "$(command git status --porcelain --ignore-submodules=dirty 2>/dev/null)" ]]; then
            dirty=" !"
        fi

        echo "#[fg=colour231,bg=colour61] git ${branch}${dirty} #[default]"
    }

    function _tmux_codex_label() {
        [[ -n "$CODEX_THREAD_ID" || -n "$CODEX_CI" ]] || _prompt_in_codex_workspace || return
        local codex_name
        codex_name="$(_prompt_codex_name)"

        if [[ -n "$codex_name" ]]; then
            echo "#[fg=colour16,bg=colour45] codex:${codex_name} #[default]"
            return
        fi

        echo "#[fg=colour16,bg=colour45] codex #[default]"
    }

    function _update_tmux_pane_title() {
        local path_style="$(_tmux_path_style_for_pwd)"
        local path_label="$(_tmux_path_label_for_pwd)"
        local git_label="$(_tmux_git_label)"
        local codex_label="$(_tmux_codex_label)"

        tmux select-pane -T "${path_style} ${path_label} #[default]${git_label}${codex_label}" 2>/dev/null
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _update_tmux_pane_title
    add-zsh-hook chpwd _update_tmux_pane_title
fi

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
