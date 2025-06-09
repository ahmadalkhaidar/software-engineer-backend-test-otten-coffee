-- No. 1 Menampilkan top 5 user yang paling banyak meminjam buku, urutkan berdasarkan jumlah
SELECT `users`.`name` as user_name, COUNT(`loans`.`id`) AS total_loans FROM `loans` LEFT JOIN `users` ON `loans`.`user_id` = `users`.`id` GROUP BY `loans`.`user_id` ORDER BY total_loans DESC
-- Komentar: 
-- `COUNT` berfungsi menghitung jumlah data dari loans.id yang dihasilkan dari query tersebut.
-- `LEFT JOIN` berfungsi menggabungkan table menggunakan kecocokan field dari masing masing table yang digabungkan.
-- `GROUP BY` berfungsi untuk mengelompokkan baris data data dari table tersebut berdasarkan nilai yang sama dari field/kolom yang dipanggil untuk mendukung fungsi aggregat
-- `ORDER BY` berfungsi untuk mengurutkan baris yang ingin ditampilan berdasarkan "ASC (Ascending)" atau "DESC (Descending)" dari field yang diurutkan


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
-- `ORDER BY` berfungsi untuk mengurutkan baris yang ingin ditampilan berdasarkan "ASC (Ascending)" atau "DESC (Descending)" dari field yang diurutkan
-- `LIMIT` berfungsi untuk membatasi jumlah baris yang ingin ditampilkan


-- No. 5 Optimasi: Tambahkan indeks apa saja yang kamu rekomendasikan untuk mempercepat query-query di atas, dan jelaskan alasannya di queries.sql sebagai komentar.
-- Komentar:
-- Untuk indexing saya akan memilih field foreign_key di table loans, seperti `user_id` dan `book_id`. Serta akan menambahkan indexing untuk field `loan_date` dan `return_date` karena akan sering digunakan untuk perintah `WHERE` agar dalam pencarian field tersebut lebih cepat.





-- Database Tables --

DROP TABLE IF EXISTS `books`;
CREATE TABLE IF NOT EXISTS `books` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);
-- Dumping data untuk tabel `books` --
INSERT INTO `books` (`id`, `title`, `author`) VALUES
(1, 'Buku 1', 'Author 1'),
(2, 'Buku 2', 'Author 2'),
(3, 'Buku 3', 'Author 3'),
(4, 'Buku 4', 'Author 4'),
(5, 'Buku 5', 'Author 5'),
(6, 'Buku 6', 'Author 6');

-- --------------------------------------------------------

-- Struktur dari tabel `loans` --
DROP TABLE IF EXISTS `loans`;
CREATE TABLE IF NOT EXISTS `loans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `book_id` int NOT NULL,
  `loan_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
);
-- Dumping data untuk tabel `loans` --
INSERT INTO `loans` (`id`, `user_id`, `book_id`, `loan_date`, `return_date`) VALUES
(1, 1, 1, '2025-06-09', '2025-06-11'),
(2, 1, 2, '2025-06-01', NULL),
(3, 1, 3, '2025-06-11', NULL),
(4, 2, 1, '2025-06-02', NULL),
(5, 2, 4, '2025-06-09', '2025-06-11'),
(6, 2, 5, '2025-06-13', NULL),
(7, 3, 1, '2025-06-16', NULL),
(8, 4, 1, '2025-06-18', NULL),
(9, 5, 1, '2025-06-06', '2025-06-10'),
(10, 6, 1, '2025-06-05', '2025-06-09'),
(11, 7, 1, '2025-06-09', '2025-06-10'),
(12, 1, 5, '2025-06-25', NULL);

-- --------------------------------------------------------

-- Struktur dari tabel `users` --
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);
-- Dumping data untuk tabel `users` --
INSERT INTO `users` (`id`, `name`, `email`) VALUES
(1, 'test', 'test@gmail.com'),
(2, 'test 2', 'test2@gmail.com'),
(3, 'test 3', 'test3@gmail.com'),
(4, 'test 4', 'test4@gmail.com'),
(5, 'test 5', 'test5@gmail.com'),
(6, 'test 6', 'test6@gmail.com'),
(7, 'test 7', 'test7@gmail.com'),
(8, 'test 8', 'test8@gmail.com');