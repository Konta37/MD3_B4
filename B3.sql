create table phieu_xuat(
so_px int primary key auto_increment,
ngay_xuat datetime
);

create table phieu_nhap(
so_pn int primary key auto_increment,
ngay_nhap datetime
);


create table phieu_xuat_chi_tiet(
so_px int,
ma_vt int,
primary key(so_px,ma_vt),
don_gia_xuat double,
so_luong_xuat int,

foreign key (so_px) references phieu_xuat(so_px),
foreign key (ma_vt) references vat_tu(ma_vt)
);

create table chi_tiet_don_dat_hang(
ma_vt int,
so_dh int,
primary key(ma_vt,so_dh),

foreign key (ma_vt) references vat_tu(ma_vt),
foreign key (so_dh) references don_dat_hang(so_dh)
);

create table nga_cung_cap(
ma_ncc int primary key auto_increment,
ten_ncc varchar(255),
dia_chi varchar(255),
so_dien_thoai varchar(255)
);

create table don_dat_hang(
so_dh int auto_increment,
ma_ncc int ,
primary key(so_dh,ma_ncc),
ngay_dh datetime,

foreign key (ma_ncc) references nga_cung_cap(ma_ncc)

);

create table vat_tu(
ma_vt int primary key auto_increment,
ten_vt varchar(255)
);

create table phieu_nhap_chi_tiet(
so_pn int,
ma_vt int,
primary key(so_pn,ma_vt),
don_gia_nhap double,
so_luong_nhap int,

foreign key (so_pn) references phieu_nhap(so_pn),
foreign key (ma_vt) references vat_tu(ma_vt)
);


show tables;

-- data


-- Insert data into vat_tu
INSERT INTO vat_tu (ten_vt) VALUES 
('Iron'),
('Steel'),
('Copper'),
('Aluminum'),
('Plastic');

-- Insert data into nga_cung_cap
INSERT INTO nga_cung_cap (ten_ncc, dia_chi, so_dien_thoai) VALUES 
('Supplier A', '123 Main St', '555-1234'),
('Supplier B', '456 Elm St', '555-5678'),
('Supplier C', '789 Maple St', '555-8765');

-- Insert data into don_dat_hang
INSERT INTO don_dat_hang (ma_ncc, ngay_dh) VALUES 
(1, '2024-07-10 10:00:00'),
(2, '2024-07-11 11:30:00'),
(3, '2024-07-12 14:45:00');
INSERT INTO don_dat_hang (ma_ncc, ngay_dh) VALUES 
(2,'2024-02-20 11:00:00'),
(3,'2024-02-21 11:00:00'),
(1,'2024-02-15 11:00:00');

-- Insert data into chi_tiet_don_dat_hang
INSERT INTO chi_tiet_don_dat_hang (ma_vt, so_dh) VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3);
INSERT INTO chi_tiet_don_dat_hang (ma_vt, so_dh) VALUES 
(1,10),
(2,11),
(4,12);

-- Insert data into phieu_nhap
INSERT INTO phieu_nhap (ngay_nhap) VALUES 
('2024-07-13 08:00:00'),
('2024-07-14 09:00:00'),
('2024-07-15 10:30:00'),
('2024-02-20 11:00:00'),
('2024-02-21 11:00:00'),
('2024-02-15 11:00:00');

-- Insert data into phieu_nhap_chi_tiet
INSERT INTO phieu_nhap_chi_tiet (so_pn, ma_vt, don_gia_nhap, so_luong_nhap) VALUES 
(1, 1, 100.5, 10),
(1, 2, 200.0, 20),
(2, 3, 150.75, 15),
(2, 4, 175.25, 25),
(3, 5, 120.0, 30);

-- Insert data into phieu_xuat
INSERT INTO phieu_xuat (ngay_xuat) VALUES 
('2024-07-16 08:00:00'),
('2024-07-17 09:30:00'),
('2024-07-18 11:00:00'),
('2024-02-20 11:00:00'),
('2024-02-21 11:00:00'),
('2024-02-15 11:00:00');

-- Insert data into phieu_xuat_chi_tiet
INSERT INTO phieu_xuat_chi_tiet (so_px, ma_vt, don_gia_xuat, so_luong_xuat) VALUES 
(1, 1, 105.5, 5),
(1, 2, 210.0, 10),
(2, 3, 160.75, 7),
(2, 4, 185.25, 12),
(3, 5, 125.0, 15);

select * from vat_tu;
select * from chi_tiet_don_dat_hang;
select * from don_dat_hang;
select * from nga_cung_cap;
select * from phieu_nhap;
select * from phieu_nhap_chi_tiet;
select * from phieu_xuat;
select * from phieu_xuat_chi_tiet;


-- show list vat_tu ban chay nhat c1
SELECT vt.ten_vt, SUM(pxc.so_luong_xuat) AS total_sold
FROM phieu_xuat_chi_tiet pxc
JOIN vat_tu vt ON pxc.ma_vt = vt.ma_vt
GROUP BY vt.ten_vt
ORDER BY total_sold DESC;

-- show list vat_tu ban chay nhat c2
select vat_tu.ten_vt, sum(phieu_xuat_chi_tiet.so_luong_xuat) as total_sold
from phieu_xuat_chi_tiet
join vat_tu on phieu_xuat_chi_tiet.ma_vt = vat_tu.ma_vt
group by vat_tu.ten_vt
order by total_sold;

-- show list vat_tu has most product in stock
select vat_tu.ten_vt, sum(phieu_nhap_chi_tiet.so_luong_nhap) as total_product
from phieu_nhap_chi_tiet
join vat_tu on phieu_nhap_chi_tiet.ma_vt = vat_tu.ma_vt
group by vat_tu.ten_vt
order by vat_tu.ten_vt;

-- show list vat_tu has nga_cung_Cap between 12/2/2024 to 22/2/2024 c1
SELECT DISTINCT ncc.ten_ncc
FROM don_dat_hang ddh
JOIN nga_cung_cap ncc ON ddh.ma_ncc = ncc.ma_ncc
WHERE ddh.ngay_dh BETWEEN '2024-02-12' AND '2024-02-22';
-- distinct la ko trung lap

-- show list vat_tu has nga_cung_Cap between 12/2/2024 to 22/2/2024 c2
select nga_cung_cap.ten_ncc, don_dat_hang.ngay_dh 
from don_dat_hang
join nga_cung_cap on don_dat_hang.ma_ncc = nga_cung_cap.ma_ncc
where don_dat_hang.ngay_dh between '2024-02-12 00:00:00' and '2024-02-22 00:00:00';

select vat_tu.ma_vt, don_dat_hang.ma_ncc
from chi_tiet_don_dat_hang ctddh
join vat_tu on vat_tu.ma_vt = ctddh.ma_vt
join don_dat_hang on don_dat_hang.so_dh = ctddh.so_dh
where don_dat_hang.ngay_dh between '2024-02-12 00:00:00' and '2024-02-22 00:00:00';	


-- session 04

-- show all vattu by phieu xuat has so_luong_xuat>10
select vat_tu.ten_vt, phieu_xuat_chi_tiet.so_luong_xuat as 'số lượng xuất' from phieu_xuat_chi_tiet
join vat_tu on vat_tu.ma_vt = phieu_xuat_chi_tiet.ma_vt
where phieu_xuat_chi_tiet.so_luong_xuat >=10;

-- show all vat tu buy at 2023-02-12
select vat_tu.ten_vt, phieu_nhap.ngay_nhap from phieu_nhap
join phieu_nhap_chi_tiet on phieu_nhap_chi_tiet.so_pn = phieu_nhap.so_pn
join vat_tu on vat_tu.ma_vt = phieu_nhap_chi_tiet.ma_vt
where phieu_nhap.ngay_nhap = '2024-07-14 09:00:00';
-- where phieu_nhap.ngay_nhap between '2024-07-14' and '2024-12-12';

-- show all vattu which unit price >1.200.000
select vat_tu.ten_vt, phieu_nhap_chi_tiet.don_gia_nhap  from phieu_nhap_chi_tiet
join vat_tu on vat_tu.ma_vt = phieu_nhap_chi_tiet.ma_vt
where phieu_nhap_chi_tiet.don_gia_nhap >= 120;

-- show all vattu which has so_luong_xuat >5
select vat_tu.ten_vt, phieu_xuat_chi_tiet.so_luong_xuat from phieu_xuat_chi_tiet
join vat_tu on vat_tu.ma_vt = phieu_xuat_chi_tiet.ma_vt
where phieu_xuat_chi_tiet.so_luong_xuat>5;

-- show all nga_cung_cap at 'Long bien' has phone start with '09..'
select * from nga_cung_cap
where nga_cung_cap.dia_chi like '%Main%'
and nga_cung_cap.so_dien_thoai like '555%';