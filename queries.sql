
-- No. 1 Menampilkan top 5 user yang paling banyak meminjam buku, urutkan berdasarkan jumlah
SELECT `users`.`name` as user_name, COUNT(`loans`.`id`) AS total_loans FROM `loans` LEFT JOIN `users` ON `loans`.`user_id` = `users`.`id` GROUP BY `loans`.`user_id` ORDER BY total_loans DESC
-- Komentar: 
-- `COUNT` berfungsi menghitung jumlah data dari loans.id yang dihasilkan dari query tersebut.
-- `LEFT JOIN` berfungsi menggabungkan table menggunakan kecocokan field dari masing masing table yang digabungkan.
-- `GROUP BY` berfungsi untuk mengelompokkan baris data data dari table tersebut berdasarkan nilai yang sama dari field/kolom yang dipanggil untuk mendukung fungsi aggregat

-- No. 2 Menghitung rata-rata durasi peminjaman (dalam hari), hanya untuk pinjaman yang sudah
SELECT AVG(DATEDIFF(`loans`.`return_date`, `loans`.`loan_date`)) AS avg_durasi_hari FROM `loans` WHERE `loans`.`return_date` IS NOT NULL;
-- Komentar: 
--  `AVG` berfungsi untuk mencari nilai rata rata, 
-- `DATEDIFF` berfungsi mencari selisih waktu (dalam hari), 
-- `WHERE return_date IS NOT NULL` berfungsi untuk memfilter data peminjaman buku yang sudah dikembalikan.

-- No. 3 Tampilkan semua user yang memiliki pinjaman aktif (belum dikembalikan) lebih dari 7 hari dari loan_date.
SELECT `loans`.`id` as loan_id, `users`.`name` as nama_user, `loans`.`loan_date` FROM `loans` LEFT JOIN `users` ON `loans`.`user_id` = `users`.`id` WHERE DATE_SUB(`loans`.`loan_date`, INTERVAL -7 DAY) <= NOW() AND `loans`.`return_date` IS NULL;
-- Komentar:
-- `LEFT JOIN` berfungsi menggabungkan table menggunakan kecocokan field dari masing masing table yang digabungkan.
-- `DATE_SUB` berfungsi mengurangi interval waktu/tanggal dari suatu tanggal lalu mengembalikan tanggal. Ini saya gunakan untuk mendapatkan nilai 7 hari kedepan dari tanggal loan date.
-- `NOW` berfungsi mendapatkan tanggal dan waktu saat ini.

-- No. 4 Tampilkan 3 buku yang paling sering dipinjam, beserta jumlah peminjamnya.
SELECT `books`.`title` as title_book, COUNT(`loans`.`id`) AS total_loans FROM `loans` LEFT JOIN `books` ON `loans`.`book_id` = `books`.`id` GROUP BY `loans`.`book_id` ORDER BY total_loans DESC LIMIT 3
-- Komentar:
-- `COUNT` berfungsi menghitung jumlah data dari loans.id yang dihasilkan dari query tersebut.
-- `LEFT JOIN` berfungsi menggabungkan table menggunakan kecocokan field dari masing masing table yang digabungkan.
-- `GROUP BY` berfungsi untuk mengelompokkan baris data data dari table tersebut berdasarkan nilai yang sama dari field/kolom yang dipanggil untuk mendukung fungsi aggregat
-- `ORDER BY` berfungsi untuk mengurutkan baris yang ingin ditampilan berdasarkan "ASC (Ascending)" atau "DESC (Descending)"
-- `LIMIT` berfungsi untuk membatasi jumlah baris yang ingin ditampilkan

-- No. 5 Optimasi: Tambahkan indeks apa saja yang kamu rekomendasikan untuk mempercepat query-query di atas, dan jelaskan alasannya di queries.sql sebagai komentar.
-- Komentar:
-- Untuk indexing saya akan memilih field foreign_key di table loans, seperti `user_id` dan `book_id`. Serta akan menambahkan indexing untuk field `loan_date` dan `return_date` karena akan sering digunakan untuk perintah `WHERE` agar dalam pencarian field tersebut lebih cepat.