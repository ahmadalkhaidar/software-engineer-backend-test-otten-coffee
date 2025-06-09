# No. 1
Untuk Arsitecture Backend nya saya akan menggunakan Microservice untuk memecahkan beberapa service, yaitu order tracking service untuk memproses perubahan status order, notification service untuk mengirim notif ke user. 
Dalam hal ini terdapat 2 arsitektur yang akan digunakan, yaitu:
- API-Driven Architecture (Orchestration Pattern) -> RESTful
- Event-Driven Architecture (Event-Carried State Transfer) -> Komunikasi Async
Kemudian saya akan menerapkan penggunaan API Gateway, Service Mesh, Database yang sesuai tepat dan sesuai kebutuhan. Kemudian jika kebutuhan lebih besar saya akan memilih cloud dari pada on-premises.
Dengan menggunakan arsitektur diatas, seharusnya dapat menghindari terjadinya polling.



# No. 2
Saya akan memilih WebSockets, karena memungkinkan server untuk mengirimkan data ke user secara proaktif tanpa perlu klien user menerus mengirimkan permintaan. metode ini sangat memungkinkan untuk pembaruan status order secara real-time.
Keunggulan dari WebSockets yaitu:
1. Kecepatan -> Latency lebih rendah
2. Efisien -> koneksi yang persistens
3. Ketersediaan -> Dapat digunakan dalam berbagai bahasa pemrograman dan platform.



# No. 3
Alur data:
Ketika kurir mengubah status akan menjalankan microservice order service untuk mengupdate status order dan menjalankan microservice notification service untuk mengirimkan notifikasi ke user.



# No. 4
Skema Database:
1. Table orders
    - id_order bigint primary key (AI)
    - id_produk int
    - id_user int
    - harga int
    - jumlah int
    - total_harga int
2. Table order_status_history
    - id_order_status_history bigint primary key (AI)
    - id_order bigint
    - status varchar

Untuk relasinya pada table order_status_history terdapat field id_order untuk relasi ke table order untuk mengcapture status history dari order tersebut.

Untuk relasi pada table orders terdapat field id_produk untuk relasi ke table produk bahwa order ini merupakan orderan untuk produk tersebut, dan terdapat field id_user untuk relasi ke table user bahwa order ini merupakan orderan dari user tersebut.



# No. 5
Untuk menskala sistem untuk data 10juta order /hari dapat menggunakan microservice, Anda perlu fokus pada kemampuan masing masing microservice untuk di-deploy dan di-scale secara independen, serta pengelolaan infrastuktur yang mendukung skala tersebut. Berikut ini cara-caranya:
1. Desain microservice yang loosely coupled dan independen
2. Menggunakan Orchestration Container
3. CI/CD (Continuous Integration/Continuous Deployment)
4. Monitoring dan Observability
5. Penggunaan API Gateway
6. Penggunaan Service Mesh
7. Penggunaan Database yang tepat
8. Penggunaan Cloud Platform

Untuk menskala sistem sistem secara horizontal, fokus pada komponen yang paling sering digunakan dan memiliki beban kerja yang tinggi, Komponen yang dapat di-scaling horizontal yaitu:
1. Scaling Microservice
2. Scaling Load Balancer
3. Scaling Database