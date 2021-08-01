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

------- UC 4: Retrieve all Data -------
select * from employee_payroll;

------- UC 5: Select Query using Cast() an GetDate() -------
select Salary from employee_payroll where EmployeeName='Rujula';
select Salary from employee_payroll where StartDate BETWEEN Cast('2007-11-12' as Date) and GetDate();

------- UC 6: Add Gender Column and Update Table Values -------
Alter table employee_payroll
add Gender char(1);

Update employee_payroll 
set Gender='M'
where EmployeeName='Rujula';
Update employee_payroll 
set Gender='F'
where EmployeeName='Ashaya Sivakumar' or EmployeeName='Harsha Varghese'or EmployeeName='Gayatri KG';

------- UC 7: Use Aggregate Functions and Group by Gender -------

select Sum(Salary) as "TotalSalary",Gender from employee_payroll group by Gender;
select Avg(Salary) as "AverageSalary",Gender from employee_payroll group by Gender;
select Min(Salary) as "MinimumSalary",Gender from employee_payroll group by Gender;
select Max(Salary) as "MaximumSalary",Gender from employee_payroll group by Gender;
select count(Salary) as "CountSalary",Gender from employee_payroll group by Gender;

------- UC 8: Add column department,PhoneNumber and Address -------
Alter table employee_payroll
add EmployeePhoneNumber BigInt,EmployeeDepartment varchar(200) not null default 'Publish',Address varchar(200) default 'Not Provided';

Update employee_payroll 
set EmployeePhoneNumber='9842905050',EmployeeDepartment='Editing',Address='Bangalore,Karnataka'
where EmployeeName='Harsha Varghese';

Update employee_payroll 
set EmployeePhoneNumber='10987252525',Address='Arizona,US'
where EmployeeName='Ashaya Sivakumar';

Update employee_payroll 
set EmployeePhoneNumber='9600054540',EmployeeDepartment='Management',Address='Chennai,TN'
where EmployeeName='Rujula';

Update employee_payroll 
set EmployeePhoneNumber='8715605050',Address='Bareilly,UP'
where EmployeeName='Gayatri KG';

------- UC 9: Rename Salary to Basic Pay and Add Deduction,Taxable pay, Income Pay , Netpay -------

EXEC sp_RENAME 'employee_payroll.Basic Pay' , 'BasicPay', 'COLUMN'
Alter table employee_payroll
add Deduction float,TaxablePay float, IncomeTax float,NetPay float;
Update employee_payroll 
set Deduction=1000
where Gender='F';
Update employee_payroll 
set Deduction=2000
where Gender='M';
update employee_payroll
set NetPay=(BasicPay - Deduction)
update employee_payroll
set NetPay=0,Deduction=0

------- UC 10: Adding another Value for Rujula in Editing Department -------

Insert into employee_Payroll(EmployeeName,BasicPay,StartDate,Address,EmployeePhoneNumber,EmployeeDepartment) values ('Rujula',250000,'2019-04-20','Chennai,TN','9600054540','Editing');

------- UC 11: Implement the ER Diagram into Payroll Service DB -------
--Create Table for Company
Create Table Company
(CompanyID int identity(1,1) primary key,
CompanyName varchar(100))
--Insert Values in Company
Insert into Company values ('Balrama'),('Amar Chitra Katha')
Select * from Company

--Create Employee Table
drop table Employee
create table Employee
(EmployeeID int identity(1,1) primary key,
CompanyIdentity int,
EmployeeName varchar(200),
EmployeePhoneNumber bigInt,
EmployeeAddress varchar(200),
StartDate date,
Gender char,
Foreign key (CompanyIdentity) references Company(CompanyID)
)
--Insert Values in Employee
insert into Employee values
(1,'Anita Yadav',9842905050,'5298 Wild Indigo, Georgia,340002','2012-03-28','F'),
(2,'Kriti Deshmuk',9842905550,'Constitution Ave Fairfield, California(CA), 94533','2017-04-22','F'),
(1,'Nandeeshwar',7812905050,'Bernard Shaw, Georgia,132001 ','2015-08-22','M'),
(2,'Sarang Nair',78129050000,'Bernard Shaw, PB Marg Bareilly','2012-08-29','M')

Select * from Employee

--Create Payroll Table
create table PayrollCalculate
(BasicPay float,
Deductions float,
TaxablePay float,
IncomeTax float,
NetPay float,
EmployeeIdentity int,
Foreign key (EmployeeIdentity) references Employee(EmployeeID)
)
--Insert Values in Payroll Table
insert into PayrollCalculate(BasicPay,Deductions,IncomeTax,EmployeeIdentity) values 
(4000000,1000000,20000,1),
(4500000,200000,4000,2),
(6000000,10000,5000,3),
(9000000,399994,6784,4)

--Update Derived attribute values 
update PayrollCalculate
set TaxablePay=BasicPay-Deductions

update PayrollCalculate
set NetPay=TaxablePay-IncomeTax

select * from PayrollCalculate

--Create Department Table
create table Department
(
DepartmentId int identity(1,1) primary key,
DepartName varchar(100)
)
--Insert Values in Department Table
insert into Department values
('Marketing'),
('Sales'),
('Publishing')

select * from Department

--Create table EmployeeDepartment
create table EmployeeDepartment
(
DepartmentIdentity int ,
EmployeeIdentity int,
Foreign key (EmployeeIdentity) references Employee(EmployeeID),
Foreign key (DepartmentIdentity) references Department(DepartmentID)
)

--Insert Values in EmployeeDepartment
insert into EmployeeDepartment values
(3,1),
(2,2),
(1,3),
(3,4)

select * from EmployeeDepartment

------- UC 12: Ensure all retrieve queries done especially in UC 4, UC 5 and UC 7 are working with new table structure -------
--UC 4: Retrieve all Data
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,EmployeeAddress,EmployeePhoneNumber,StartDate,Gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,DepartName
FROM Company
INNER JOIN Employee ON Company.CompanyID = Employee.CompanyIdentity
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID
INNER JOIN EmployeeDepartment on Employee.EmployeeID=EmployeeDepartment.EmployeeIdentity
INNER JOIN Department on Department.DepartmentId=EmployeeDepartment.DepartmentIdentity

SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,DepartName
FROM Company
INNER JOIN Employee ON Company.CompanyID = Employee.CompanyIdentity and StartDate BETWEEN Cast('2015-11-12' as Date) and GetDate()
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID
INNER JOIN EmployeeDepartment on Employee.EmployeeID=EmployeeDepartment.EmployeeIdentity
INNER JOIN Department on Department.DepartmentId=EmployeeDepartment.DepartmentIdentity

SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,DepartName
FROM Company
INNER JOIN Employee ON Company.CompanyID = Employee.CompanyIdentity and Employee.EmployeeName='Sarang Nair'
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID
INNER JOIN EmployeeDepartment on Employee.EmployeeID=EmployeeDepartment.EmployeeIdentity
INNER JOIN Department on Department.DepartmentId=EmployeeDepartment.DepartmentIdentity



