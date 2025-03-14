# **Penjelasan Implementasi Fitur dalam Kode Godot (GDScript)**

## **1. Dash**
Fitur **dash** memungkinkan karakter untuk melakukan lompatan cepat ke arah tertentu (kanan atau kiri) dalam waktu singkat.

### **Implementasi Dash dalam Kode**
- Saat pemain melepaskan tombol **ui_right** atau **ui_left**, **can_dash** diatur menjadi `true` dan **dash_timer** dimulai.
- Jika pemain menekan kembali **ui_right** (ke kanan) atau **ui_left** (ke kiri) dan **can_dash** masih `true`, maka:
  - Kecepatan horizontal (`velocity.x`) diatur ke `dash_speed` (`1000`).
  - Status **is_dashing** diatur menjadi `true`.
  - **dash_duration_timer** dimulai, untuk mengatur berapa lama dash berlangsung.
- Setelah durasi dash berakhir (`_on_dash_duration_timeout()`):
  - **is_dashing** diatur kembali menjadi `false`.
  - **on_dash_cooldown** diatur menjadi `true`, yang memulai **dash_cooldown_timer** agar dash tidak bisa dilakukan langsung lagi.
- Setelah cooldown selesai (`_on_dash_cooldown_timeout()`):
  - **on_dash_cooldown** diatur kembali ke `false`, sehingga karakter bisa melakukan dash lagi.

### **Ringkasan Proses Dash**
1. Lepaskan tombol gerakan untuk mempersiapkan dash.
2. Tekan tombol gerakan lagi untuk melakukan dash cepat.
3. Dash berlangsung selama beberapa waktu.
4. Setelah selesai, cooldown mencegah dash langsung dilakukan lagi.

---

## **2. Double Jump**
Fitur **double jump** memungkinkan karakter untuk melompat dua kali saat berada di udara.

### **Implementasi Double Jump dalam Kode**
- Saat karakter berada di tanah (`is_on_floor()`), **can_double_jump** diatur kembali menjadi `true`, memungkinkan lompatan kedua.
- Jika pemain menekan tombol **ui_up** saat di tanah, kecepatan vertikal (`velocity.y`) diatur ke **jump_speed** (`-300`), yang menyebabkan karakter melompat.
- Jika pemain masih di udara dan memiliki **can_double_jump**, serta menekan tombol **ui_up**:
  - Kecepatan vertikal (`velocity.y`) diatur menjadi `0.8 * jump_speed` (agar lompatan kedua lebih kecil).
  - **can_double_jump** diatur ke `false`, mencegah lompatan tambahan.

### **Ringkasan Proses Double Jump**
1. Saat di tanah, lompat pertama bisa dilakukan.
2. Saat di udara, lompat kedua bisa dilakukan jika belum digunakan.
3. Setelah lompat kedua dilakukan, karakter tidak bisa melompat lagi sampai menyentuh tanah.

---

## **3. Crouch**
Fitur **crouch** memungkinkan karakter untuk menunduk, memperlambat kecepatan berjalan, dan mengubah frame sprite untuk menunjukkan karakter sedang menunduk.

### **Implementasi Crouch dalam Kode**
- Jika pemain menekan tombol `"crouch"`:
  - Jika **is_crouching** saat ini `true` (karakter sedang menunduk), maka:
    - **walk_speed** dikembalikan ke normal (`dikali 2`).
    - Frame sprite (`sprite.frame`) diatur ke `0` untuk kembali ke posisi berdiri.
    - **is_crouching** diatur ke `false`.
  - Jika **is_crouching** saat ini `false` (karakter berdiri), maka:
    - **walk_speed** diperlambat (`dikali 0.5`).
    - Frame sprite (`sprite.frame`) diatur ke `3` untuk menunjukkan karakter menunduk.
    - **is_crouching** diatur ke `true`.

### **Ringkasan Proses Crouch**
1. Tekan tombol **crouch** → karakter menunduk, kecepatan berjalan berkurang.
2. Tekan tombol **crouch** lagi → karakter kembali berdiri, kecepatan berjalan normal.


## **Referensi**
Semua Implementasi adalah pure hasil kerja saya sendiri dari pengalaman, sehingga tidak ada referensi yang bisa saya berikan.


# TUTORIAL 5

Membuat minimal 1 (satu) objek baru di dalam permainan yang dilengkapi dengan animasi menggunakan spritesheet selain yang disediakan tutorial. Silakan cari spritesheet animasi di beberapa koleksi aset gratis seperti Kenney.

Object yang dibuat adalah slime, dengan animasi idle.

Membuat minimal 1 (satu) audio untuk efek suara (SFX) dan memasukkannya ke dalam permainan. Kamu dapat membuatnya sendiri atau mencari dari koleksi aset gratis.
Membuat minimal 1 (satu) musik latar (background music) dan memasukkannya ke dalam permainan. Kamu dapat membuatnya sendiri atau mencari dari koleksi aset gratis.
Implementasikan interaksi antara objek baru tersebut dengan objek yang dikendalikan pemain. Misalnya, pemain dapat menciptakan atau menghilangkan objek baru tersebut ketika menekan suatu tombol atau tabrakan dengan objek lain di dunia permainan.
Implementasikan audio feedback dari interaksi antara objek baru dengan objek pemain. Misalnya, muncul efek suara ketika pemain tabrakan dengan objek baru.
Beberapa ide lain yang bisa kamu coba kerjakan di luar latihan mandiri:

Implementasi sistem audio yang relatif terhadap posisi objek. Misalnya, musik latar akan semakin terdengar samar ketika pemain semakin jauh dari posisi awal level.