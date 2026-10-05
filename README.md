dotfiles
========

My dotfiles and a bootstrap setup file

Packages are managed with GNU Stow. Run `make simulate_all` to preview changes
and `make` to link all packages into your home directory.

To link only Karabiner-Elements, run `stow --target="$HOME" --restow karabiner`.
Move any existing `~/.config/karabiner` directory to a backup location first.
The package includes settings and custom rule assets; automatic backups are
excluded from version control.
