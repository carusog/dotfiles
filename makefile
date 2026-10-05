# Dotfiles makefile — links every package (top-level directory) into $HOME
# using GNU Stow.
#
# Usage (run from the repository root):
#   make                # same as `make all`: create/refresh all symlinks
#   make simulate_all   # dry run: print what `make all` would do, change nothing
#   make delete         # remove every symlink created by this repository
#
# To work on a single package, call stow directly, e.g.:
#   stow --restow kitty                 # (re)link one package
#   stow --restow --no-folding fish     # packages listed in NO_FOLD below
#   stow --delete kitty                 # unlink one package
#
# Shared Stow options (target directory, ignore patterns) live in ./.stowrc,
# which Stow reads automatically when run from this directory.

# Packages whose target directories also hold machine-local files
# (e.g. ~/.config/git/config.local, ~/.config/fish/fish_variables,
# ~/.config/tmux/plugins, zed caches). Stowing them with --no-folding links
# individual files instead of the whole directory, so those local files never
# end up inside this repository.
NO_FOLD := fish git mise tmux zed

# Every top-level directory is a package: `ls -d */` lists them with a
# trailing slash ("nvim/"), which patsubst strips ("nvim").
ALL := $(patsubst %/,%,$(shell ls -d */))

# Packages that may be folded, i.e. Stow can replace a whole target directory
# with a single symlink (e.g. ~/.config/nvim -> repo/nvim/.config/nvim).
FOLD := $(filter-out $(NO_FOLD),$(ALL))

# Base command. --target is also set in .stowrc; repeating it here keeps the
# makefile self-explanatory and independent of that file.
STOW := stow --verbose --target=$(HOME)

# These targets are commands, not files.
.PHONY: all simulate_all delete

# --restow = unlink then link again, which also prunes stale symlinks.
all:
	$(STOW) --restow $(FOLD)
	$(STOW) --restow --no-folding $(NO_FOLD)

# Same as `all`, but --simulate only prints the planned actions.
simulate_all:
	$(STOW) --simulate --restow $(FOLD)
	$(STOW) --simulate --restow --no-folding $(NO_FOLD)

# Remove all symlinks pointing into this repository (files in the repo stay).
delete:
	$(STOW) --delete $(ALL)
