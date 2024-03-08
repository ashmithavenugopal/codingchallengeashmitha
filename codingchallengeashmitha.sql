create database carrentals

create table vehicles(
vehicle_id int not null primary key,
make varchar(30),
model varchar(25),
v_year int,
dailyrate decimal(10,2),
available bit,
passenger_capacity int,
engine_capacity int
);

create table customers(
customer_id int not null primary key,
first_name varchar(25),
last_name varchar(25),
email varchar(25),
phonenumber varchar(15)
);

create table lease(
lease_id int not null primary key,
vehicle_id int,
foreign key (vehicle_id) references vehicles(vehicle_id) on delete cascade,
customer_id int,
foreign key (customer_id) references customers(customer_id) on delete cascade,
startdate Date,
enddate Date,
lease_type varchar(20)
);

create table payments(
payment_id int not null primary key,
lease_id int,
foreign key (lease_id) references lease(lease_id) on delete cascade,
payment_date Date,
amount decimal(10,2)
);

insert into vehicles (vehicle_id,make,model,v_year,dailyrate,available,passenger_capacity,engine_capacity) 
values 
(1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450 ),
(2, 'Honda' ,'Civic' ,2023 ,45.00, 1 ,7 ,1500),
(3, 'Ford', 'Focus' ,2022 ,48.00, 0, 4, 1400 ),
(4, 'Nissan',' Altima' ,2023, 52.00 ,1, 7, 1200),
(5 ,'Chevrolet', 'Malibu' ,2022, 47.00, 1, 4,1800),
(6, 'Hyundai' ,'Sonata' ,2023, 49.00, 0 ,7 ,1400 ),
(7 ,'BMW', '3 Series', 2023, 60.00 ,1 ,7 ,2499 ),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599 ),
(9, 'Audi' ,'A4', 2022, 55.00, 0, 4, 2500),
(10,' Lexus', 'ES', 2023, 54.00, 1 ,4, 2500 );

insert into customers(customer_id,first_name,last_name,email,phonenumber)
values
(1 ,'John' ,'Doe', 'johndoe@example.com', '555-555-5555' ),
(2,' Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert',' Johnson' ,'robert@example.com','555-789-1234'),
(4,'Sarah',' Brown' ,'sarah@example.com','555-456-7890'),
(5,'David', 'Lee', 'david@example.com','555-987-6543' ),
(6,'Laura', 'Hall ','laura@example.com','555-234-5678' ),
(7, 'Michael',' Davis',' michael@example.com','555-876-5432'),
(8,'Emma', 'Wilson', 'emma@example.com','555-432-1098' ),
(9, 'William', 'Taylor',' william@example.com','555-321-6547'),
(10,'Olivia', 'Adams', 'olivia@example.com','555-765-4321');

insert into lease (lease_id,vehicle_id,customer_id,startdate,enddate,lease_type)
values 
(1, 1, 1 ,'2023-01-01', '2023-01-05 ','Daily'),
(2, 2, 2 ,'2023-02-15 ','2023-02-28', 'Monthly'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, 4, '2023-04-20 ','2023-04-30', 'Monthly'),
(5, 5, 5, '2023-05-05 ','2023-05-10' ,'Daily' ),
(6, 4, 3 ,'2023-06-15', '2023-06-30', 'Monthly '),
(7, 7 ,7, '2023-07-01', '2023-07-10 ','Daily' ),
(8, 8 ,8, '2023-08-12' ,'2023-08-15','Monthly'),
(9, 3 ,3 ,'2023-09-07' ,'2023-09-10 ','Daily '),
(10 ,10 ,10 ,'2023-10-10','2023-10-31', 'Monthly');

insert into Payments(payment_id, lease_id, payment_date, amount)  values
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);

select * from vehicles
select* from customers
select* from lease
select * from payments


------1. Update the daily rate for a Mercedes car to 68. 
update vehicles 
set dailyrate=68
where make='mercedes'

select*from vehicles

------2. Delete a specific customer and all associated leases and payments. 

delete from customers where customer_id=2

------3. Rename the "paymentDate" column in the Payment table to "transactionDate". 

exec sp_rename 'payments.payment_date' , 'transactiondate' , 'column';

------4. Find a specific customer by email. 

select customer_id ,first_name, last_name from customers 
where email = 'sarah@example.com'

------5. Get active leases for a specific customer.

update Lease set endDate = '2024-03-30' where customer_id = 8;

select L.* from lease l where customer_id=8 and enddate >= GETDATE()

------6. Find all payments made by a customer with a specific phone number. 

select p.* from payments p 
join lease l on p.lease_id=l.lease_id
join customers c on l.customer_id=c.customer_id
where c.phonenumber= '555-555-5555'  

------7. Calculate the average daily rate of all available cars.

select avg(dailyrate) as average_daily_rate from vehicles

------8. Find the car with the highest daily rate. 

select top 1* from vehicles order by dailyrate desc

------9. Retrieve all cars leased by a specific customer.

select v.* from vehicles v 
join lease l on v.vehicle_id=l.vehicle_id 
join customers c on  l.customer_id=c.customer_id
where c.customer_id=7

------10. Find the details of the most recent lease. 

select top 1* from lease order by startdate desc

------11. List all payments made in the year 2023. 

select * from payments where year(transactiondate) = 2023

------12. Retrieve customers who have not made any payments. 

select c.* from customers c 
join lease l on c.customer_id=l.customer_id
join payments p on l.lease_id=p.lease_id
where payment_id is null

------13. Retrieve Car Details and Their Total Payments.

select v.vehicle_id,v.make,v.model,v.dailyrate, sum(p.amount) as total_payments from vehicles v 
join lease l on v.vehicle_id=l.vehicle_id 
join payments p on l.lease_id=p.lease_id
group by v.vehicle_id,v.make,v.model,v.dailyrate

------14. Calculate Total Payments for Each Customer. 

select c.customer_id , c.first_name, sum(p.amount) as total_payments from customers c
join lease l on c.customer_id=l.customer_id 
join payments p on l.lease_id=p.lease_id
group by c.customer_id, c.first_name

------15. List Car Details for Each Lease. 

select l.lease_id,v.vehicle_id,v.make,v.model,v.v_year,v.dailyrate from lease l
join vehicles v on l.vehicle_id = v.vehicle_id

------16. Retrieve Details of Active Leases with Customer and Car Information. 

select l.lease_id,c.customer_id , c.first_name,v.vehicle_id,v.make,v.model,v.v_year,v.dailyrate from lease l 
join customers c on l.customer_id=c.customer_id
join vehicles v on l.vehicle_id=v.vehicle_id
where c.customer_id=8 and enddate >= GETDATE()

------17. Find the Customer Who Has Spent the Most on Leases.

select c.customer_id , c.first_name ,  sum(amount) as spent_amount from customers c 
join lease l on c.customer_id=l.customer_id
join payments p on l.lease_id=p.lease_id
group by c.customer_id,c.first_name
order by spent_amount desc

------18. List All Cars with Their Current Lease Information.

select v.vehicle_id,v.make,v.model,v.v_year,v.dailyrate,l.lease_id, l.startdate,l.enddate,c.customer_id,c.first_name from vehicles v
join lease l on v.vehicle_id =l.vehicle_id
join customers c on l.customer_id= c.customer_id








