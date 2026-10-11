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

mkdir -p "$HOME/.config/i3" "$HOME/.config/i3status" "$HOME/.local/bin" "$HOME/.local/share/blankon-bandit/logo"

cp "$repo_dir/home/.config/i3/config" "$HOME/.config/i3/config"
cp "$repo_dir/home/.config/i3status/config" "$HOME/.config/i3status/config"
cp "$repo_dir/home/.local/bin/bandit-bar-logo" "$HOME/.local/bin/bandit-bar-logo"
cp "$repo_dir/logo/bandit.jpg" "$HOME/.local/share/blankon-bandit/logo/bandit.jpg"

chmod +x "$HOME/.local/bin/bandit-bar-logo"

echo "BlankOn Bandit i3 dotfiles installed."
echo "Reload i3 with Mod+Shift+c."
