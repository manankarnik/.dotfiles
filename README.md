# .dotfiles

Linux configuration files

## Clone Repo

```sh
git clone https://github.com/manankarnik/.dotfiles.git
```

## Change Directory

```sh
cd .dotfiles
```

## Build System Configuration

```sh
sudo nixos-rebuild switch --flake .#
```

## Build Home Configuration

```sh
home-manager switch --flake .#<user>
```
