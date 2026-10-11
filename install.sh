#!/bin/sh
# Install the BlankOn Bandit dotfiles into the current user's home directory.

set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
mkdir -p "$HOME/.config/i3" "$HOME/.config/i3status" "$HOME/.local/bin" "$HOME/.local/share/blankon-bandit/logo"

cp "$repo_dir/home/.config/i3/config" "$HOME/.config/i3/config"
cp "$repo_dir/home/.config/i3status/config" "$HOME/.config/i3status/config"
cp "$repo_dir/home/.local/bin/bandit-bar-logo" "$HOME/.local/bin/bandit-bar-logo"
cp "$repo_dir/logo/bandit.jpg" "$HOME/.local/share/blankon-bandit/logo/bandit.jpg"

chmod +x "$HOME/.local/bin/bandit-bar-logo"

echo "BlankOn Bandit i3 dotfiles installed."
echo "Required packages: i3, i3status, dmenu, feh, and a configured x-terminal-emulator."
echo "Reload i3 with Mod+Shift+c."
