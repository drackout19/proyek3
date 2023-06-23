-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2023 at 07:18 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `proyek3_baletani`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_name_buruh` (IN `v_id_buruh` INT)   BEGIN
SELECT get_name_buruh(v_id_buruh);
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_name_buruh` (`v_id_buruh` INT) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
DECLARE v_nama VARCHAR(30);
SELECT nama into v_nama FROM buruh_tani WHERE id_buruh=v_id_buruh;
RETURN v_nama;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `akun_pengguna`
--

CREATE TABLE `akun_pengguna` (
  `id_akun` int(11) NOT NULL,
  `kontak` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `akun_pengguna`
--

INSERT INTO `akun_pengguna` (`id_akun`, `kontak`, `password`) VALUES
(2103053, '081', '123'),
(2103054, '0818', '123'),
(2103055, '086', '123'),
(2103056, '098', 'coba'),
(2103057, '067', 'coba'),
(2103058, '085', 'coba'),
(2103059, '084', 'coba'),
(2103060, '083', 'coba'),
(2103061, '999', 'coba'),
(2103064, '777', 'coba'),
(2103065, '444', '123'),
(2103068, '333', '123');

-- --------------------------------------------------------

--
-- Table structure for table `alamat_buruh`
--

CREATE TABLE `alamat_buruh` (
  `id_alamat` int(11) NOT NULL,
  `id_buruh` int(11) DEFAULT NULL,
  `alamat` varchar(30) NOT NULL,
  `rt` varchar(5) DEFAULT NULL,
  `rw` varchar(5) DEFAULT NULL,
  `kel_desa` varchar(11) DEFAULT NULL,
  `kecamatan` varchar(20) DEFAULT NULL,
  `kabupaten` varchar(20) DEFAULT NULL,
  `provinsi` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `alamat_buruh`
--

INSERT INTO `alamat_buruh` (`id_alamat`, `id_buruh`, `alamat`, `rt`, `rw`, `kel_desa`, `kecamatan`, `kabupaten`, `provinsi`) VALUES
(34, 52, 'singajaya', NULL, NULL, NULL, NULL, NULL, NULL),
(35, 53, 'jl ir h juanda no.34', NULL, NULL, NULL, NULL, NULL, NULL),
(36, 54, 'balongan', NULL, NULL, NULL, NULL, NULL, NULL),
(37, 55, 'terusan', '1', '1', 'terusan', 'terusan', 'indramayu', 'jabar'),
(38, 56, 'terusan', '1', '1', 'singaraja', 'ind', 'ind', 'jabar'),
(39, 57, 'singajya', '1', '1', 'singajaya', 'ind', 'ind', 'jabar'),
(40, 58, 'desa singajaya', NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Triggers `alamat_buruh`
--
DELIMITER $$
CREATE TRIGGER `UPDATE_ALAMAT` BEFORE UPDATE ON `alamat_buruh` FOR EACH ROW BEGIN
IF EXISTS(SELECT id_buruh FROM backup_alamat_buruh WHERE id_buruh=OLD.id_buruh) THEN
UPDATE backup_alamat_buruh SET id_alamat=OLD.id_alamat, id_buruh=OLD.id_buruh, alamat=OLD.alamat, rt=OLD.rt, rw=OLD.rw, kel_desa=OLD.kel_desa, kecamatan=OLD.kecamatan, kabupaten=OLD.kabupaten, provinsi=OLD.provinsi;
ELSE
INSERT INTO `backup_alamat_buruh`(`id_alamat`, `id_buruh`, `alamat`, `rt`, `rw`, `kel_desa`, `kecamatan`, `kabupaten`, `provinsi`) VALUES (OLD.id_alamat, OLD.id_buruh, OLD.alamat, OLD.rt, OLD.rw, OLD.kel_desa, OLD.kecamatan, OLD.kabupaten, OLD.provinsi);
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `backup_alamat_buruh`
--

CREATE TABLE `backup_alamat_buruh` (
  `id_alamat` int(11) NOT NULL,
  `id_buruh` int(11) DEFAULT NULL,
  `alamat` varchar(30) NOT NULL,
  `rt` varchar(5) DEFAULT NULL,
  `rw` varchar(5) DEFAULT NULL,
  `kel_desa` varchar(11) DEFAULT NULL,
  `kecamatan` varchar(20) DEFAULT NULL,
  `kabupaten` varchar(20) DEFAULT NULL,
  `provinsi` varchar(20) DEFAULT NULL,
  `update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_alamat_buruh`
--

INSERT INTO `backup_alamat_buruh` (`id_alamat`, `id_buruh`, `alamat`, `rt`, `rw`, `kel_desa`, `kecamatan`, `kabupaten`, `provinsi`, `update`) VALUES
(37, 55, 'terusan', NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-14 04:20:29'),
(38, 56, 'terusan', NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-14 05:04:07'),
(39, 57, 'singjaya', NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-15 03:25:28');

-- --------------------------------------------------------

--
-- Table structure for table `backup_ktp`
--

CREATE TABLE `backup_ktp` (
  `id_ktp` int(11) NOT NULL,
  `id_buruh` int(11) DEFAULT NULL,
  `nik_ktp` varchar(20) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `tempat_lahir` varchar(20) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `id_alamat` int(11) DEFAULT NULL,
  `foto_ktp` varchar(100) NOT NULL,
  `foto_selfie_ktp` varchar(100) NOT NULL,
  `update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_ktp`
--

INSERT INTO `backup_ktp` (`id_ktp`, `id_buruh`, `nik_ktp`, `nama`, `tempat_lahir`, `tgl_lahir`, `id_alamat`, `foto_ktp`, `foto_selfie_ktp`, `update`) VALUES
(25, 55, '456', 'abdul', 'indramayu', '2019-06-03', 37, 'scaled_kindpng_846856.png', 'scaled_kindpng_1243246.png', '2023-06-14 04:20:29'),
(26, 56, '123', 'abdul', 'indramayu', '2019-06-03', 38, 'scaled_kindpng_1243085.png', 'scaled_kindpng_1243246.png', '2023-06-14 05:04:07'),
(27, 57, '2103', 'amirul', 'indramayu', '2019-06-03', 39, 'scaled_kindpng_1243246.png', 'scaled_kindpng_1243085.png', '2023-06-15 03:25:28');

-- --------------------------------------------------------

--
-- Table structure for table `buruh_tani`
--

CREATE TABLE `buruh_tani` (
  `id_buruh` int(11) NOT NULL,
  `id_akun` int(11) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `id_alamat` int(11) DEFAULT NULL,
  `kontak` varchar(20) NOT NULL,
  `jenis_kelamin` varchar(10) NOT NULL,
  `umur` int(10) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `biaya_jasa` int(10) DEFAULT NULL,
  `foto_profile` varchar(30) DEFAULT NULL,
  `foto_sampul` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buruh_tani`
--

INSERT INTO `buruh_tani` (`id_buruh`, `id_akun`, `nama`, `id_alamat`, `kontak`, `jenis_kelamin`, `umur`, `deskripsi`, `biaya_jasa`, `foto_profile`, `foto_sampul`) VALUES
(52, 2103053, 'amirul', 34, '081', 'pria', 30, NULL, NULL, NULL, NULL),
(53, 2103056, 'amirul', 35, '098', 'pria', 19, NULL, NULL, NULL, NULL),
(54, 2103058, 'regina', 36, '085', 'wanita', 20, NULL, NULL, NULL, NULL),
(55, 2103059, 'abdul', 37, '084', 'pria', 20, NULL, NULL, NULL, NULL),
(56, 2103060, 'abdul', 38, '083', 'pria', 20, NULL, NULL, NULL, NULL),
(57, 2103064, 'amiurl', 39, '777', 'pria', 20, NULL, NULL, NULL, NULL),
(58, 2103061, 'amirul', 40, '999', 'pria', 19, NULL, NULL, NULL, NULL);

--
-- Triggers `buruh_tani`
--
DELIMITER $$
CREATE TRIGGER `INSERT` AFTER INSERT ON `buruh_tani` FOR EACH ROW BEGIN
INSERT INTO konfirmasi_buruh_tani(id_buruh, status) VALUES (NEW.id_buruh, 0);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `konfirmasi_buruh_tani`
--

CREATE TABLE `konfirmasi_buruh_tani` (
  `id_konfirmasi` int(11) NOT NULL,
  `id_buruh` int(11) DEFAULT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `konfirmasi_buruh_tani`
--

INSERT INTO `konfirmasi_buruh_tani` (`id_konfirmasi`, `id_buruh`, `status`) VALUES
(39, 52, 1),
(40, 53, 1),
(41, 54, 0),
(42, 55, 0),
(43, 56, 0),
(44, 57, 0),
(45, 58, 0);

-- --------------------------------------------------------

--
-- Table structure for table `konfirmasi_edit_ktp`
--

CREATE TABLE `konfirmasi_edit_ktp` (
  `id_edit` int(11) NOT NULL,
  `id_ktp` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `konfirmasi_edit_ktp`
--
DELIMITER $$
CREATE TRIGGER `UPDATE_STATUS` BEFORE UPDATE ON `konfirmasi_edit_ktp` FOR EACH ROW BEGIN

DECLARE v_nik INT default 0;
DECLARE v_nama VARCHAR(50);
DECLARE v_tmpt_lahir VARCHAR(30);
DECLARE v_tgl_lahir DATE;
DECLARE v_foto_ktp VARCHAR(100);
DECLARE v_foto_selfie_ktp VARCHAR(100);

IF (NEW.status = 1) THEN
SELECT nik_ktp, nama, tempat_lahir, tgl_lahir, foto_ktp, foto_selfie_ktp INTO v_nik, v_nama, v_tmpt_lahir, v_tgl_lahir, v_foto_ktp, v_foto_selfie_ktp FROM ktp WHERE id_buruh=19;
UPDATE backup_ktp SET nik_ktp=v_nik,nama=v_nama,tempat_lahir=v_tmpt_lahir,tgl_lahir=v_tgl_lahir,foto_ktp=v_foto_ktp,foto_selfie_ktp=v_foto_selfie_ktp WHERE id_buruh=19;

END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `konfirmasi_member`
--

CREATE TABLE `konfirmasi_member` (
  `id_konfirmasi` int(11) NOT NULL,
  `id_ktp` int(11) DEFAULT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `konfirmasi_member`
--

INSERT INTO `konfirmasi_member` (`id_konfirmasi`, `id_ktp`, `status`) VALUES
(15, 27, 0),
(16, 28, 0),
(17, 29, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ktp`
--

CREATE TABLE `ktp` (
  `id_ktp` int(11) NOT NULL,
  `id_buruh` int(11) DEFAULT NULL,
  `nik_ktp` varchar(20) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `tempat_lahir` varchar(20) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `id_alamat` int(11) DEFAULT NULL,
  `foto_ktp` varchar(100) NOT NULL,
  `foto_selfie_ktp` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ktp`
--

INSERT INTO `ktp` (`id_ktp`, `id_buruh`, `nik_ktp`, `nama`, `tempat_lahir`, `tgl_lahir`, `id_alamat`, `foto_ktp`, `foto_selfie_ktp`) VALUES
(27, 55, '456', 'abdul', 'indramayu', '2019-06-03', 37, 'scaled_kindpng_846856.png', 'scaled_kindpng_1243246.png'),
(28, 56, '123', 'abdul', 'indramayu', '2019-06-03', 38, 'scaled_kindpng_1243085.png', 'scaled_kindpng_1243246.png'),
(29, 57, '2103', 'amirul', 'indramayu', '2019-06-03', 39, 'scaled_kindpng_1243246.png', 'scaled_kindpng_1243085.png');

--
-- Triggers `ktp`
--
DELIMITER $$
CREATE TRIGGER `INSERT_DATA` BEFORE INSERT ON `ktp` FOR EACH ROW BEGIN
INSERT INTO backup_ktp(id_buruh, nik_ktp, nama, tempat_lahir, tgl_lahir, id_alamat, foto_ktp, foto_selfie_ktp) 
  VALUES(NEW.id_buruh, NEW.nik_ktp, NEW.nama, NEW.tempat_lahir, NEW.tgl_lahir, NEW.id_alamat, NEW.foto_ktp, NEW.foto_selfie_ktp);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UPDATE_TEST` BEFORE UPDATE ON `ktp` FOR EACH ROW BEGIN
INSERT INTO backup_ktp(id_ktp, id_buruh, nik_ktp, nama, tempat_lahir, tgl_lahir, id_alamat, foto_ktp, foto_selfie_ktp) VALUES (OLD.id_ktp,OLD.id_buruh,OLD.nik_ktp,OLD.nama,OLD.tempat_lahir,OLD.tgl_lahir,OLD.id_alamat,OLD.foto_ktp,OLD.foto_selfie_ktp);
INSERT INTO konfirmasi_edit_ktp(id_ktp, status) VALUES (OLD.id_ktp, 0);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `member_tani`
--

CREATE TABLE `member_tani` (
  `id_member` int(11) NOT NULL,
  `id_buruh` int(11) NOT NULL,
  `status` int(5) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `postingan`
--

CREATE TABLE `postingan` (
  `id_post` int(11) NOT NULL,
  `id_akun` int(11) NOT NULL,
  `judul` varchar(30) NOT NULL,
  `deskripsi` text NOT NULL,
  `biaya_jasa` double NOT NULL,
  `tanggal_post` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rating_buruh`
--

CREATE TABLE `rating_buruh` (
  `id_rating` int(11) NOT NULL,
  `id_buruh` int(11) NOT NULL,
  `rating` double DEFAULT NULL,
  `jumlah_tersewa` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload_image`
--

CREATE TABLE `upload_image` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `upload_image`
--

INSERT INTO `upload_image` (`id`, `name`, `image`) VALUES
(39, 'budi', 'scaled_IMG_20230415_124416.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `upload_image_ktp`
--

CREATE TABLE `upload_image_ktp` (
  `nama` varchar(30) NOT NULL,
  `ktp` varchar(100) NOT NULL,
  `selfie_ktp` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `upload_image_ktp`
--

INSERT INTO `upload_image_ktp` (`nama`, `ktp`, `selfie_ktp`) VALUES
('micu', '', ''),
('tyno', 'scaled_IMG_20230415_124416.jpg', 'scaled_IMG_20230415_124416.jpg'),
('tyno', '', 'scaled_IMG_20230415_124416.jpg'),
('tyno', '', 'scaled_IMG_20230415_124416.jpg'),
('tyno_jelek', 'scaled_IMG_20230415_124416.jpg', 'scaled_IMG_20230415_124416.jpg'),
('', '', ''),
('tyno_micu', 'scaled_IMG_20230415_124416.jpg', 'scaled_IMG_20230415_124416.jpg'),
('tyno', 'scaled_Revolution Wallpaper Naruto HD Wallpaper 1080p.png', 'scaled_IMG_20230415_124416.jpg'),
('tyno', 'scaled_Revolution Wallpaper Naruto HD Wallpaper 1080p.png', 'scaled_IMG_20230415_124416.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun_pengguna`
--
ALTER TABLE `akun_pengguna`
  ADD PRIMARY KEY (`id_akun`),
  ADD UNIQUE KEY `kontak` (`kontak`);

--
-- Indexes for table `alamat_buruh`
--
ALTER TABLE `alamat_buruh`
  ADD PRIMARY KEY (`id_alamat`),
  ADD KEY `id_buruh` (`id_buruh`);

--
-- Indexes for table `backup_alamat_buruh`
--
ALTER TABLE `backup_alamat_buruh`
  ADD PRIMARY KEY (`id_alamat`),
  ADD KEY `id_buruh` (`id_buruh`);

--
-- Indexes for table `backup_ktp`
--
ALTER TABLE `backup_ktp`
  ADD PRIMARY KEY (`id_ktp`),
  ADD KEY `id_buruh` (`id_buruh`),
  ADD KEY `id_alamat` (`id_alamat`);

--
-- Indexes for table `buruh_tani`
--
ALTER TABLE `buruh_tani`
  ADD PRIMARY KEY (`id_buruh`),
  ADD UNIQUE KEY `kontak` (`kontak`),
  ADD KEY `buruh_tani_ibfk_2` (`id_alamat`),
  ADD KEY `id_akun` (`id_akun`);

--
-- Indexes for table `konfirmasi_buruh_tani`
--
ALTER TABLE `konfirmasi_buruh_tani`
  ADD PRIMARY KEY (`id_konfirmasi`),
  ADD KEY `konfirmasi_member_ibfk_1` (`id_buruh`);

--
-- Indexes for table `konfirmasi_edit_ktp`
--
ALTER TABLE `konfirmasi_edit_ktp`
  ADD PRIMARY KEY (`id_edit`),
  ADD KEY `id_ktp` (`id_ktp`);

--
-- Indexes for table `konfirmasi_member`
--
ALTER TABLE `konfirmasi_member`
  ADD PRIMARY KEY (`id_konfirmasi`),
  ADD KEY `konfirmasi_member_ibfk_1` (`id_ktp`);

--
-- Indexes for table `ktp`
--
ALTER TABLE `ktp`
  ADD PRIMARY KEY (`id_ktp`),
  ADD KEY `id_buruh` (`id_buruh`),
  ADD KEY `id_alamat` (`id_alamat`);

--
-- Indexes for table `member_tani`
--
ALTER TABLE `member_tani`
  ADD PRIMARY KEY (`id_member`),
  ADD KEY `id_buruh` (`id_buruh`);

--
-- Indexes for table `postingan`
--
ALTER TABLE `postingan`
  ADD PRIMARY KEY (`id_post`),
  ADD KEY `id_akun` (`id_akun`);

--
-- Indexes for table `rating_buruh`
--
ALTER TABLE `rating_buruh`
  ADD PRIMARY KEY (`id_rating`),
  ADD KEY `id_buruh` (`id_buruh`);

--
-- Indexes for table `upload_image`
--
ALTER TABLE `upload_image`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `akun_pengguna`
--
ALTER TABLE `akun_pengguna`
  MODIFY `id_akun` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2103069;

--
-- AUTO_INCREMENT for table `alamat_buruh`
--
ALTER TABLE `alamat_buruh`
  MODIFY `id_alamat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `backup_alamat_buruh`
--
ALTER TABLE `backup_alamat_buruh`
  MODIFY `id_alamat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `backup_ktp`
--
ALTER TABLE `backup_ktp`
  MODIFY `id_ktp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `buruh_tani`
--
ALTER TABLE `buruh_tani`
  MODIFY `id_buruh` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `konfirmasi_buruh_tani`
--
ALTER TABLE `konfirmasi_buruh_tani`
  MODIFY `id_konfirmasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `konfirmasi_edit_ktp`
--
ALTER TABLE `konfirmasi_edit_ktp`
  MODIFY `id_edit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `konfirmasi_member`
--
ALTER TABLE `konfirmasi_member`
  MODIFY `id_konfirmasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `ktp`
--
ALTER TABLE `ktp`
  MODIFY `id_ktp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `member_tani`
--
ALTER TABLE `member_tani`
  MODIFY `id_member` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `postingan`
--
ALTER TABLE `postingan`
  MODIFY `id_post` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `rating_buruh`
--
ALTER TABLE `rating_buruh`
  MODIFY `id_rating` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `upload_image`
--
ALTER TABLE `upload_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alamat_buruh`
--
ALTER TABLE `alamat_buruh`
  ADD CONSTRAINT `alamat_buruh_ibfk_1` FOREIGN KEY (`id_buruh`) REFERENCES `buruh_tani` (`id_buruh`) ON DELETE SET NULL;

--
-- Constraints for table `backup_alamat_buruh`
--
ALTER TABLE `backup_alamat_buruh`
  ADD CONSTRAINT `backup_alamat_buruh_ibfk_1` FOREIGN KEY (`id_buruh`) REFERENCES `buruh_tani` (`id_buruh`) ON DELETE SET NULL;

--
-- Constraints for table `backup_ktp`
--
ALTER TABLE `backup_ktp`
  ADD CONSTRAINT `backup_ktp_ibfk_1` FOREIGN KEY (`id_buruh`) REFERENCES `buruh_tani` (`id_buruh`),
  ADD CONSTRAINT `backup_ktp_ibfk_2` FOREIGN KEY (`id_alamat`) REFERENCES `alamat_buruh` (`id_alamat`);

--
-- Constraints for table `buruh_tani`
--
ALTER TABLE `buruh_tani`
  ADD CONSTRAINT `buruh_tani_ibfk_2` FOREIGN KEY (`id_alamat`) REFERENCES `alamat_buruh` (`id_alamat`),
  ADD CONSTRAINT `buruh_tani_ibfk_3` FOREIGN KEY (`id_akun`) REFERENCES `akun_pengguna` (`id_akun`);

--
-- Constraints for table `konfirmasi_buruh_tani`
--
ALTER TABLE `konfirmasi_buruh_tani`
  ADD CONSTRAINT `konfirmasi_buruh_tani_ibfk_1` FOREIGN KEY (`id_buruh`) REFERENCES `buruh_tani` (`id_buruh`);

--
-- Constraints for table `konfirmasi_edit_ktp`
--
ALTER TABLE `konfirmasi_edit_ktp`
  ADD CONSTRAINT `konfirmasi_edit_ktp_ibfk_1` FOREIGN KEY (`id_ktp`) REFERENCES `ktp` (`id_ktp`);

--
-- Constraints for table `konfirmasi_member`
--
ALTER TABLE `konfirmasi_member`
  ADD CONSTRAINT `konfirmasi_member_ibfk_1` FOREIGN KEY (`id_ktp`) REFERENCES `ktp` (`id_ktp`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `ktp`
--
ALTER TABLE `ktp`
  ADD CONSTRAINT `ktp_ibfk_1` FOREIGN KEY (`id_buruh`) REFERENCES `buruh_tani` (`id_buruh`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `ktp_ibfk_2` FOREIGN KEY (`id_alamat`) REFERENCES `alamat_buruh` (`id_alamat`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `member_tani`
--
ALTER TABLE `member_tani`
  ADD CONSTRAINT `member_tani_ibfk_1` FOREIGN KEY (`id_buruh`) REFERENCES `buruh_tani` (`id_buruh`);

--
-- Constraints for table `postingan`
--
ALTER TABLE `postingan`
  ADD CONSTRAINT `postingan_ibfk_1` FOREIGN KEY (`id_akun`) REFERENCES `akun_pengguna` (`id_akun`);

--
-- Constraints for table `rating_buruh`
--
ALTER TABLE `rating_buruh`
  ADD CONSTRAINT `rating_buruh_ibfk_1` FOREIGN KEY (`id_buruh`) REFERENCES `buruh_tani` (`id_buruh`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
