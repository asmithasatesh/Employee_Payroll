------- UC 1: Create Database -------
create database payroll_services
use payroll_services

------- UC 2: Create Table -------
Create Table employee_payroll
(EmployeeID int identity(1,1) primary key,
EmployeeName varchar(100),
Salary float,
StartDate Date)

------- UC 3: Insert Values in Table -------
Insert into employee_payroll(EmployeeName,Salary,StartDate) values 
('Harsha Varghese',15000,'2021-03-12'),
('Ashaya Sivakumar',1000,'2021-07-18'),
('Rujula',250000,'2019-04-20'),
('Gayatri KG',19000,'2007-02-22');

select * from employee_payroll;