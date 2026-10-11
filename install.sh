#!/bin/sh
# Install the BlankOn Bandit dotfiles into the current user's home directory.

set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if ! command -v apt-get >/dev/null 2>&1; then
    echo "Error: apt-get tidak ditemukan. Script ini ditujukan untuk BlankOn/Debian." >&2
    exit 1
fi

packages=""
command -v i3 >/dev/null 2>&1 || packages="$packages i3"
command -v i3status >/dev/null 2>&1 || packages="$packages i3status"
command -v dmenu_run >/dev/null 2>&1 || packages="$packages dmenu"
command -v feh >/dev/null 2>&1 || packages="$packages feh"
command -v polybar >/dev/null 2>&1 || packages="$packages polybar"
command -v convert >/dev/null 2>&1 || packages="$packages imagemagick"

# i3 memanggil x-terminal-emulator. Jika belum tersedia, pasang terminal
# ringan yang umum tersedia di repositori Debian/BlankOn.
if ! command -v x-terminal-emulator >/dev/null 2>&1; then
    packages="$packages xfce4-terminal"
fi

if [ -n "$packages" ]; then
    echo "Memasang dependency:$packages"
    if [ "$(id -u)" -eq 0 ]; then
        apt-get update
        apt-get install -y $packages
    elif command -v sudo >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y $packages
    else
        echo "Error: dependency belum lengkap dan sudo tidak ditemukan." >&2
        echo "Jalankan sebagai root atau pasang manual:$packages" >&2
        exit 1
    fi
else
    echo "Semua dependency sudah tersedia."
fi

mkdir -p "$HOME/.config/i3" "$HOME/.config/i3status" "$HOME/.config/polybar" "$HOME/.local/bin" "$HOME/.local/share/blankon-bandit/logo" "$HOME/.local/share/blankon-bandit/wallpaper"

cp "$repo_dir/home/.config/i3/config" "$HOME/.config/i3/config"
cp "$repo_dir/home/.config/i3status/config" "$HOME/.config/i3status/config"
cp "$repo_dir/home/.config/polybar/config.ini" "$HOME/.config/polybar/config.ini"
cp "$repo_dir/home/.local/bin/bandit-bar-logo" "$HOME/.local/bin/bandit-bar-logo"
cp "$repo_dir/home/.local/bin/bandit-polybar" "$HOME/.local/bin/bandit-polybar"
cp "$repo_dir/home/.local/bin/bandit-wallpaper" "$HOME/.local/bin/bandit-wallpaper"
cp "$repo_dir/logo/bandit.jpg" "$HOME/.local/share/blankon-bandit/logo/bandit.jpg"
cp "$repo_dir/wallpaper/amel.png" "$HOME/.local/share/blankon-bandit/wallpaper/amel.png"

# Create a compact face-only mark for the bar. The original artwork includes
# the word BANDIT, which is kept as Polybar text beside the mark.
convert "$HOME/.local/share/blankon-bandit/logo/bandit.jpg" \
    -gravity center -crop 1024x780+0+0 +repage \
    -resize 30x30^ -extent 30x30 \
    -background '#ff851b' -alpha remove -alpha off \
    "$HOME/.local/share/blankon-bandit/logo/bandit-mark.png"

chmod +x "$HOME/.local/bin/bandit-bar-logo"
chmod +x "$HOME/.local/bin/bandit-polybar"
chmod +x "$HOME/.local/bin/bandit-wallpaper"

echo "BlankOn Bandit i3 dotfiles installed."
echo "Reload i3 with Mod+Shift+c."
