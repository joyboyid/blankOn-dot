# BlankOn Bandit i3 dotfiles

Dotfiles i3 bertema Bandit untuk BlankOn Linux. Paletnya mengikuti logo yang tersedia: oranye, ungu, hijau neon, hitam, dan putih krem. Bar menggunakan Polybar dengan gaya floating/pill terinspirasi BlackNode.

## Instalasi

Jalankan dari direktori proyek:

```sh
./install.sh
```

Script akan mengecek dan memasang dependency yang belum tersedia menggunakan `apt-get` dan `sudo`, lalu memasang konfigurasi ke `~/.config/i3`, `~/.config/i3status`, `~/.config/polybar`, dan `~/.local/bin`.

Wallpaper `wallpaper/amel.png` juga akan dipasang dan diterapkan otomatis saat i3 dimulai atau di-reload.

Paket yang dibutuhkan:

Dependency yang dipasang otomatis:

- `i3`
- `i3status`
- `dmenu`
- `feh`
- `polybar`
- `xfce4-terminal` jika `x-terminal-emulator` belum tersedia

Jika ingin memakai terminal lain, ubah nilai `$term` di `home/.config/i3/config` sebelum instalasi.

Logo Bandit ditampilkan sebagai overlay kecil di sisi kiri Polybar menggunakan `feh`. Polybar dipakai sebagai bar i3 karena mendukung panel floating, sudut membulat, modul terpisah, dan layout kiri-tengah-kanan seperti referensi BlackNode.

Jika bar tidak muncul, periksa log dengan:

```sh
cat "${XDG_RUNTIME_DIR:-/tmp}/blankon-bandit-polybar.log"
```
