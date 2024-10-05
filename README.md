# f2b-telegram-notifier

## Deskripsi
`f2b-telegram-notifier` adalah bash script yang berfungsi untuk mengirim laporan IP yang diblokir oleh Fail2Ban ke bot Telegram. Script ini juga menampilkan informasi sistem dan IP jaringan server, serta menambahkan lokasi geolokasi berdasarkan IP yang diblokir. Hasil laporan dikirim dalam bentuk teks dan file `.txt` melalui bot Telegram, dilengkapi dengan timestamp.

## Fitur
- Menampilkan informasi sistem dan IP jaringan
- Mengambil IP yang diblokir oleh Fail2Ban
- Menggunakan GeoIP untuk menentukan lokasi dari IP yang diblokir
- Mengirimkan laporan ke bot Telegram sebagai teks dan file `.txt`
- Menyertakan timestamp pada laporan

## Kebutuhan Paket Linux
Agar script berjalan dengan baik, beberapa paket harus terpasang di server Anda:
- `iptables`
- `geoip-bin`
- `fail2ban`
- `curl`

### Instalasi Paket yang Dibutuhkan
Untuk menginstal paket-paket yang dibutuhkan di sistem berbasis Debian/Ubuntu, jalankan perintah berikut:

```bash
sudo apt-get update
sudo apt-get install iptables geoip-bin fail2ban curl
