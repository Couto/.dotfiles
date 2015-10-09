# .dotfiles

## Instalation

This repository uses [rcm](https://github.com/thoughtbot/rcm), so you should install and familiarize with the tool first.

I usually start by manually creating the symlink to `.rcrc` like:

```bash
ln -s ~/.dotfiles/host-Smokings/rcrc ~/.rcrc
rcup
```

The repository is divided into tags, so you can easily cherry-pick what you want to use.
So if you just want my tmux and vim settings you can do something like:

```bash
git clone git@github.com:Couto/.dotfiles ~/Couto-dotfiles
rcup -d Couto-dotfiles -t tmux -t vim -x README.md -x modules -x plugins
```

It also contains per host configuration. These represent the computers where I usually work

```bash
git clone git@github.com:Couto/.dotfiles ~/.dotfiles
rcup -o Smokings
```

