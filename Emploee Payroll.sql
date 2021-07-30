------- UC 1: Create Database -------
create database payroll_services
use payroll_services

------- UC 2: Create Table -------
Create Table employee_payroll
(EmployeeID int identity(1,1) primary key,
EmployeeName varchar(100),
Salary float,
StartDate Date)