CREATE DATABASE QuanLyOngHut
GO

USE QuanLyOngHut
GO

-- TaiKhoan
-- SanPham
-- DonDatHang
-- KhachHang
-- DaiLy
-- HoaDon
-- BaoCao
-- ChiTietDonHang
-- LichSuMuaHang

CREATE TABLE TaiKhoan (
    TenDangNhap NVARCHAR(100) NOT NULL PRIMARY KEY,
    MatKhau NVARCHAR(1000) NULL,
    Email NVARCHAR(100) NULL
)
GO

CREATE TABLE SanPham
(
	MaSP NVARCHAR(100) PRIMARY KEY,  -- Ma San Pham(Khoa chinh, duy nhat)
	TenSP NVARCHAR(100),
	Loai NVARCHAR(100),
	KichThuoc NVARCHAR(100),
	MauSac NVARCHAR(100),
	SoLuongTon INT
)
GO

CREATE TABLE KhachHang
(
	MaKH NVARCHAR(100) PRIMARY KEY,  -- Ma Khach Hang(Khoa chinh)
	TenKH NVARCHAR(100),
	DiaChi NVARCHAR(100),
	SoDT NVARCHAR(100),
	Email NVARCHAR(100)
)
GO

CREATE TABLE DonDatHang
(
	MaDon NVARCHAR(100) PRIMARY KEY,   --Ma Don Hang (Khoa chinh)
	NgayDat DATE,
	MaKH NVARCHAR(100) FOREIGN KEY REFERENCES KhachHang(MaKH),    -- Lien ket Khach hang
	TongTien DECIMAL(18, 2)
)
GO

CREATE TABLE ChiTietDonHang
(
	MaDon NVARCHAR(100),                                
    MaSP NVARCHAR(100),                                 
    SoLuong INT,                                       
    DonGia DECIMAL(18, 2),                             
    PRIMARY KEY (MaDon, MaSP),                         -- Khoa chinh ket hop (1 don co nhieu san pham)
    FOREIGN KEY (MaDon) REFERENCES DonDatHang(MaDon),  -- Lien ket den don hang
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)        -- Lien ket den san pham
)
GO

CREATE TABLE DaiLy
(
	MaDaiLy NVARCHAR(10) PRIMARY KEY,   -- Ma dai ly (duy nhat)
    TenDL NVARCHAR(50),                 -- Ten dai ly
    DiaChi NVARCHAR(100),               -- Dia chi
    SoDT NVARCHAR(15),                  -- So dien thoai
    Email NVARCHAR(50)                  -- Email dai ly
)
GO

CREATE TABLE HoaDon 
(
    MaHD NVARCHAR(100) PRIMARY KEY,                                        -- Ma Hoa Don
    MaDon NVARCHAR(100),												   -- Gan voi 1 don dat hang
    NgayLap DATE,                                                          -- Ngay lap hoa don
    BaoHanh NVARCHAR(100),												   -- Thong tin bao hanh
	FOREIGN KEY (MaDon) REFERENCES DonDatHang(MaDon)
)
GO

CREATE VIEW v_ThongKe_DoanhSo_TheoLoai_Thang_Nam AS
SELECT 
    YEAR(D.NgayDat) AS Nam,
    MONTH(D.NgayDat) AS Thang,
    S.Loai,
    SUM(CT.SoLuong) AS TongSoLuongBan,
    SUM(CT.SoLuong * CT.DonGia) AS DoanhThu,
    SUM(CT.SoLuong * CT.DonGia * 0.2) AS LoiNhuan  -- ví dụ 20% lợi nhuận
FROM DonDatHang D
JOIN ChiTietDonHang CT ON D.MaDon = CT.MaDon
JOIN SanPham S ON CT.MaSP = S.MaSP
GROUP BY YEAR(D.NgayDat), MONTH(D.NgayDat), S.Loai
GO

CREATE VIEW v_TimKiemTongHop AS
SELECT 
    MaKH AS MaDoiTuong,
    TenKH AS TenDoiTuong,
    'KhachHang' AS Loai,
    SoDT,
    Email
FROM KhachHang
UNION
SELECT 
    MaDaiLy,
    TenDL,
    'DaiLy',
    SoDT,
    Email
FROM DaiLy
UNION
SELECT 
    MaSP,
    TenSP,
    'SanPham',
    NULL,
    NULL
FROM SanPham
GO

CREATE TABLE BaoCao 
(	
    MaBaoCao NVARCHAR(20) PRIMARY KEY,
    NgayLap DATE,
    Loai NVARCHAR(100), -- VD: Ống hút thường
    Nam INT,
    Thang INT,
    SoLuongBan INT,
    DoanhThu DECIMAL(18,2),
    LoiNhuan DECIMAL(18,2)
)
GO

CREATE TABLE LichSuMuaHang (
    MaLS INT IDENTITY PRIMARY KEY,
    MaKH NVARCHAR(100),
    MaSP NVARCHAR(100),
    NgayMua DATE,
    SoLuong INT,
    DonGia DECIMAL(18,2),
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
)
GO

INSERT INTO TaiKhoan
( 
	TenDangNhap,
	MatKhau,
	Email
)
VALUES
(
	N'admin',
	N'adminhkt',
	N'adminhkt@gmail.com'
)

INSERT INTO TaiKhoan
( 
	TenDangNhap,
	MatKhau,
	Email
)
VALUES
(
	N'MinhThao',
	N'mtdanang',
	N'minhthao@gmail.com'
)

INSERT INTO KhachHang
(
	MaKH,
	TenKH, 
	DiaChi,
	SoDT, 
	Email
)
VALUES
(
	N'KH1',
	N'Linh',
	N'Hà Nội',
	N'012345678',
	N'linh@gmail.com'
)

SELECT * FROM TaiKhoan;
SELECT * FROM KhachHang;