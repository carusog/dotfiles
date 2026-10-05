# ~/.zprofile — sourced by login shells, after ~/.zshenv.

typeset -U path PATH manpath MANPATH

# Homebrew (Apple Silicon or Intel)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# JetBrains Toolbox scripts
toolbox_scripts="$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
[[ -d "$toolbox_scripts" ]] && path+=("$toolbox_scripts")
unset toolbox_scripts

# MacPorts
if [[ -d /opt/local/bin ]]; then
  path=(/opt/local/bin /opt/local/sbin $path)
  manpath=(/opt/local/share/man $manpath)
fi

# Keep ~/.local/bin ahead of Homebrew/MacPorts (already added in ~/.zshenv;
# re-prepending moves it to the front, typeset -U removes the duplicate).
path=("$HOME/.local/bin" $path)
