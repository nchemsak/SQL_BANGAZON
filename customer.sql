DELETE FROM Customers;
DELETE FROM Payment_Types;
DELETE FROM Products;
DELETE FROM Product_Types;
DELETE FROM Payment_Types_has_Customers;
DELETE FROM Orders_has_Products;
DELETE FROM Orders;

DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Payment_Types;
DROP TABLE IF EXISTS Product_Types;
DROP TABLE IF EXISTS Payment_Types_has_Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders_has_Products;
DROP TABLE IF EXISTS Orders;


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

