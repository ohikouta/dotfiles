# dotfiles

# セットアップ
1. 本リポジトリをクローン
```
git clone git@github.com/ohikouta/dotfiles.git ~/.config
```

2. submodule(nvim)を取得
```
cd ~/.config && git submodule update --init --recursive
```

3. nvimの更新手順
nvimのリポをpullすると、親リポにdiffが出るので、コミットする
```
cd ~/.config/nvim && git pull
```
```
git add nvim && git commit
```
