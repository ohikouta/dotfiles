# Repository Guidelines

## Project Structure & Module Organization
This repository is a personal dotfiles tree rooted at `~/.config`. Tracked directories in this repo map directly to one tool or app, including `zsh/.zshrc`, `tmux/tmux.conf`, `wezterm/wezterm.lua`, `ghostty/config`, and `karabiner/karabiner.json`. Neovim lives in `nvim/` and is tracked as a Git submodule. Paths such as `fish/config.fish` and `raycast/extensions/` may exist locally under `~/.config`, but they are local-only and gitignored rather than tracked in this repository. Treat generated assets such as `.map` files and app state under `configstore/` as managed outputs unless you are intentionally updating them.

## Build, Test, and Development Commands
Clone into the expected path so configs resolve correctly:

```sh
git clone git@github.com/ohikouta/dotfiles.git ~/.config
cd ~/.config && git submodule update --init --recursive
```

For Neovim submodule updates, pull inside `nvim/` and then commit the submodule pointer from the repo root. For Raycast extensions, run commands from the relevant extension directory, for example:

```sh
npm run lint
npm run build
npm run dev
```

These scripts wrap `ray lint`, `ray build`, and `ray develop`.

## Coding Style & Naming Conventions
Preserve each tool's native format: Lua in `nvim/` and `wezterm/`, shell-style syntax in `zsh/` and `tmux/`, JSON in `karabiner/` and `configstore/`. Use 2-space indentation in JSON and the existing style elsewhere. Keep filenames conventional for the target tool, and prefer descriptive plugin or config names such as `lua/config/options.lua`. If you touch Neovim formatting, use `stylua`; Raycast extensions use `eslint`, `prettier`, and `ray lint`.

## Testing Guidelines
There is no repo-wide test suite. Validate changes with the narrowest relevant check: `npm run lint` or `npm run build` for Raycast extensions, and application-native reloads for shell and terminal configs. After editing user-facing keybindings or startup behavior, include a brief manual verification note in the PR.

## Commit & Pull Request Guidelines
Recent history uses short, scoped commit subjects such as `wezterm:...`, `feat:...`, and `chore:...`; follow that pattern and keep commits focused to one tool or behavior change. Pull requests should explain what changed, which app or config area is affected, how you verified it, and include screenshots only when UI-visible behavior changed.

## Security & Configuration Tips
Do not commit secrets, tokens, machine-specific host data, or transient caches. Review diffs in `configstore/`, `gh/hosts.yml`, and Raycast extension settings carefully before committing.
