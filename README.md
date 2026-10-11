# BlankOn Bandit i3 dotfiles

Dotfiles i3 bertema Bandit untuk BlankOn Linux. Paletnya mengikuti logo yang tersedia: oranye, ungu, hijau neon, hitam, dan putih krem.

## Instalasi

Jalankan dari direktori proyek:

```sh
./install.sh
```

Konfigurasi akan dipasang ke `~/.config/i3`, `~/.config/i3status`, dan `~/.local/bin`.

Paket yang dibutuhkan:

```sh
sudo apt install i3 i3status dmenu feh
```

Jika terminal default belum terkonfigurasi, ubah nilai `$term` di `home/.config/i3/config` sebelum instalasi, misalnya menjadi `xfce4-terminal` atau `gnome-terminal`.

Logo Bandit ditampilkan sebagai overlay kecil di sisi kiri i3bar menggunakan `feh`, karena protokol i3bar native hanya mendukung teks, bukan gambar raster.
