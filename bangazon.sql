-- BANGAZON SQL
DELETE FROM Computers_has_Employees;
DELETE FROM Employees;
DELETE FROM Departments;
DELETE FROM Computers;
DELETE FROM Training_programs;
DELETE FROM Training_Programs_has_Employees;

-- CUSTOMER SQL
DELETE FROM Customers;
DELETE FROM Payment_Types;
DELETE FROM Products;
DELETE FROM Product_Types;
DELETE FROM Payment_Types_has_Customers;
DELETE FROM Orders_has_Products;
DELETE FROM Orders;

-- BANGAZON SQL
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Computers;
DROP TABLE IF EXISTS Training_programs;
DROP TABLE IF EXISTS Computers_has_Employees;
DROP TABLE IF EXISTS Training_Programs_has_Employees;

-- CUSTOMER SQL
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Payment_Types;
DROP TABLE IF EXISTS Product_Types;
DROP TABLE IF EXISTS Payment_Types_has_Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders_has_Products;
DROP TABLE IF EXISTS Orders;



----------------------------------------------------------------
--                     BANGAZON SQL
----------------------------------------------------------------



CREATE TABLE `Employees` (
  `EmployeesId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `First_name` TEXT NOT NULL,
  `Last_name` TEXT NOT NULL,
  `Training_program` TEXT NULL,
  `Type_of_employee` TEXT NOT NULL,
  `Departments_DepartmentsId` INTEGER NOT NULL,
  FOREIGN KEY(`Departments_DepartmentsId`) REFERENCES `Departments`(`DepartmentsId`)
);

CREATE TABLE `Computers_has_Employees` (
  `Computers_ComputersId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Employees_EmployeesId` INTEGER NOT NULL,
  -- INDEX `fk_Computers_has_Employees_Employees1_idx` (`Employees_EmployeesId` ASC),
  -- INDEX `fk_Computers_has_Employees_Computers1_idx` (`Computers_ComputersId` ASC),
  CONSTRAINT `fk_Computers_has_Employees_Computers1`
    FOREIGN KEY (`Computers_ComputersId`) REFERENCES `Computers` (`ComputersId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Computers_has_Employees_Employees1`
    FOREIGN KEY (`Employees_EmployeesId`) REFERENCES `Employees` (`EmployeesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE `Departments` (
  `DepartmentsId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Name` TEXT NULL,
  `Supervisor` TEXT NULL,
  `Budget` INTEGER NULL
);

CREATE TABLE `Computers` (
  `ComputersId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Purchase_date` DATE NOT NULL,
  `Decommissioned_date` DATE NULL,
  `Employees_EmployeesId` INTEGER NOT NULL,
  `Cost` INTEGER NOT NULL,
  FOREIGN KEY(`Employees_EmployeesId`) REFERENCES `Employees`(`EmployeesId`)
);

CREATE TABLE `Training_Programs` (
  `Training_ProgramsId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Start_date` DATE NOT NULL,
  `End_date` DATE NOT NULL,
  `Max_attendees` INTEGER NOT NULL,
  `name` TEXT NOT NULL
);

CREATE TABLE `Training_Programs_has_Employees` (
  `Training_Programs_Training_ProgramsId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Employees_EmployeesId` INTEGER NOT NULL,
  -- INDEX `fk_Training Programs_has_Employees_Employees1_idx` (`Employees_EmployeesId` ASC),
  -- INDEX `fk_Training Programs_has_Employees_Training Programs1_idx` (`Training Programs_Training ProgramsId` ASC),
  CONSTRAINT `fk_Training_Programs_has_Employees_Training_Programs1`
    FOREIGN KEY (`Training_Programs_Training_ProgramsId`) REFERENCES `Training_Programs` (`Training_ProgramsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Training_Programs_has_Employees_Employees1`
    FOREIGN KEY (`Employees_EmployeesId`) REFERENCES `Employees` (`EmployeesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);



----------------------------------------------------------------
--                     CUSTOMER SQL
----------------------------------------------------------------



CREATE TABLE `Customers` (
  `CustomersId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `First_name` TEXT NOT NULL,
  `Last_name` TEXT NOT NULL,
  `Account_create_date` DATE NOT NULL,
  `Last_activity_date` DATE NOT NULL
  );

CREATE TABLE `Payment_Types` (
  `Payment_TypesId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Categories` TEXT NOT NULL,
  `Payment_method` TEXT NOT NULL,
  `Account_number` INTEGER NOT NULL
  );

CREATE TABLE `Products` (
  `ProductsId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Price` INTEGER NOT NULL,
  `Title` TEXT NOT NULL,
  `Description` TEXT NOT NULL,
  `Product_Types_Product_TypesId` INTEGER NOT NULL,
  `Customers_CustomersId` INTEGER NOT NULL,
  -- INDEX `fk_Products_Product_Types1_idx` (`Product_Types_Product_TypesId` ASC),
  -- UNIQUE INDEX `Title_UNIQUE` (`Title` ASC),
  -- INDEX `fk_Products_Customers1_idx` (`Customers_CustomersId` ASC),
  CONSTRAINT `fk_Products_Product_Types1`
    FOREIGN KEY (`Product_Types_Product_TypesId`) REFERENCES `Product_Types` (`Product_TypesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_Customers1`
    FOREIGN KEY (`Customers_CustomersId`) REFERENCES `Customers` (`CustomersId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


CREATE TABLE `Product_Types` (
  `Product_TypesId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Name` TEXT NOT NULL
  );


CREATE TABLE `Payment_Types_has_Customers` (
  `Payment_Types_Payment_TypesId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Customers_CustomersId` INTEGER NOT NULL,
  -- INDEX `fk_Payment_Types_has_Customers_Customers1_idx` (`Customers_CustomersId` ASC),
  -- INDEX `fk_Payment_Types_has_Customers_Payment_Types1_idx` (`Payment_Types_Payment_TypesId` ASC),
  CONSTRAINT `fk_Payment_Types_has_Customers_Payment_Types1`
    FOREIGN KEY (`Payment_Types_Payment_TypesId`) REFERENCES `Payment_Types` (`Payment_TypesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_Types_has_Customers_Customers1`
    FOREIGN KEY (`Customers_CustomersId`) REFERENCES `Customers` (`CustomersId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


CREATE TABLE `Orders_has_Products` (
  `Orders_OrdersId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Products_ProductsId` INTEGER NOT NULL,
  -- INDEX `fk_Orders_has_Products_Products1_idx` (`Products_ProductsId` ASC),
  -- INDEX `fk_Orders_has_Products_Orders1_idx` (`Orders_OrdersId` ASC),
  CONSTRAINT `fk_Orders_has_Products_Orders1`
    FOREIGN KEY (`Orders_OrdersId`) REFERENCES `Orders` (`OrdersId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_has_Products_Products1`
    FOREIGN KEY (`Products_ProductsId`) REFERENCES `Products` (`ProductsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


CREATE TABLE `Orders` (
  `OrdersId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Customers_CustomersId` INTEGER NOT NULL,
  `Total_Cost` INTEGER NOT NULL,
  `Payment Types_Payment_TypesId` INTEGER NOT NULL,
  -- INDEX `fk_Orders_Customers1_idx` (`Customers_CustomersId` ASC),
  -- INDEX `fk_Orders_Payment Types1_idx` (`Payment Types_Payment_TypesId` ASC),
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customers_CustomersId`) REFERENCES `Customers` (`CustomersId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Payment Types1`
    FOREIGN KEY (`Payment Types_Payment_TypesId`) REFERENCES `Payment_Types` (`Payment_TypesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );
