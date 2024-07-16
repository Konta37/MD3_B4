create table customer(
c_id int primary key auto_increment,
c_name varchar(255) not null unique,
c_age int not null
);

create table order_table(
o_id int auto_increment,
c_id int not null,
o_date datetime not null,
o_total_price double check (o_total_price > 0) default 1,

primary key (o_id,c_id),
foreign key (c_id) references customer(c_id)
);

create table order_detail(
o_id int ,
p_id int not null,
od_quantity int check (od_quantity >= 0),
primary key(o_id,p_id),

foreign key (p_id) references product(p_id),
foreign key (o_id) references order_table(o_id)
);

create table product(
p_id int primary key auto_increment,
p_name varchar(255),
p_price double check (p_price > 0) default 1
);

show tables;


-- add data
insert into customer(c_name,c_age) values
('Minh Quân', 10),
('Ngọc Oanh', 20),
('Hồng Hà', 50)
;

insert into order_table(c_id,o_date,o_total_price) values
(1,'2006-03-21',150000),
(2,'2006-03-23',200000),
(1,'2006-03-16',170000)
;

insert into product(p_name,p_price) values 
('Máy giặt', 300),
('Tủ Lạnh', 500),
('Điều Hoà', 700),
('Quạt', 100),
('Bếp điện', 200),
('Máy hút bụi', 500)
;

insert into order_detail(o_id,p_id,od_quantity) values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3)
;

select o_id as 'order id',c_id as 'customer id',o_total_price as 'quantity' from order_table;

select * from customer;
select * from order_table;

-- find any customer who doesnt buy anything
select * from customer where c_id not in (select distinct c_id from order_table);


-- find customers who buy anything
select customer.c_name, order_detail.od_quantity from customer
inner join order_table on customer.c_id = order_table.c_id
INNER JOIN order_detail ON order_table.o_id = order_detail.o_id;

-- show order id, date, total
select * from order_table;
select * from order_detail;
select * from product;

SELECT 
    order_table.o_id,
    order_table.o_date,
    order_detail.p_id,
    (order_detail.od_quantity * product.p_price) AS totals
FROM
    order_table
        JOIN
    order_detail ON order_detail.o_id = order_table.o_id
        JOIN
    product ON order_detail.p_id = product.p_id;
    
    
-- session 04
select customer.c_name, order_table.o_total_price from order_table
join customer on customer.c_id = order_table.c_id
where order_table.o_total_price >= 150000;

-- show product which hasnt been bought
select * from product 
where product.p_id not in (select distinct order_detail.p_id from  order_detail);

select * from order_detail;


-- show all product has been bought
select product.p_name, count(order_detail.od_quantity) as cntProduct from order_detail
join product on product.p_id = order_detail.p_id
group by order_detail.p_id;

-- show all product has been bought > 2
select p_name, cntProduct 
from
(select product.p_name, count(order_detail.od_quantity) as cntProduct from order_detail
join product on product.p_id = order_detail.p_id
group by order_detail.p_id) as cnt
where cntProduct >=2
order by cntProduct;

-- show 1 order in order_table which has max o_total_price
select order_table.o_id, max(order_table.o_total_price) as max from order_table
group by order_table.o_id 
order by max  desc
limit 1;

-- show product which has biggest price
select product.p_name, max(product.p_price) as maxprice from product
group by product.p_name
order by maxprice desc
limit 1;

-- show customer who buy "bep dien" the most
select customer.c_name ,Sum(order_detail.od_quantity) from order_detail
join order_table on order_table.o_id = order_detail.o_id
join customer on customer.c_id = order_table.c_id
join product on product.p_id = order_detail.p_id
where product.p_name = 'Bếp điện'
group by customer.c_id
;

select * from customer;
select * from product;
select * from order_table;
select * from order_detail;