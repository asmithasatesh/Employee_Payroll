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