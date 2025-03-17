CREATE DATABASE IF NOT EXISTS BusinessDB;
USE BusinessDB;

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address TEXT
);

-- Invoices Table
CREATE TABLE Invoices (
    InvoiceID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    InvoiceDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- ShippingDetails Table
CREATE TABLE ShippingDetails (
    ShippingID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceID INT,
    Address TEXT NOT NULL,
    ShippingDate DATE NOT NULL,
    EstimatedArrival DATE NOT NULL,
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID) ON DELETE CASCADE
);

-- Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL
);

-- TaxRates Table
CREATE TABLE TaxRates (
    TaxID INT AUTO_INCREMENT PRIMARY KEY,
    TaxName VARCHAR(255) NOT NULL,
    Rate DECIMAL(5,2) NOT NULL
);

-- Discounts Table
CREATE TABLE Discounts (
    DiscountID INT AUTO_INCREMENT PRIMARY KEY,
    DiscountName VARCHAR(255) NOT NULL,
    DiscountValue DECIMAL(5,2) NOT NULL
);

-- InvoiceDetails Table
CREATE TABLE InvoiceDetails (
    DetailID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    TaxID INT,
    DiscountID INT,
    LineTotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (TaxID) REFERENCES TaxRates(TaxID) ON DELETE SET NULL,
    FOREIGN KEY (DiscountID) REFERENCES Discounts(DiscountID) ON DELETE SET NULL
);

-- PaymentStatus Table
CREATE TABLE PaymentStatus (
    StatusID INT AUTO_INCREMENT PRIMARY KEY,
    StatusName VARCHAR(255) NOT NULL,
    Description TEXT
);

-- PaymentMethods Table
CREATE TABLE PaymentMethods (
    MethodID INT AUTO_INCREMENT PRIMARY KEY,
    MethodName VARCHAR(255) NOT NULL,
    Description TEXT
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceID INT,
    PaymentAmount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod INT,
    PaymentStatus INT,
    PaymentReference VARCHAR(255) UNIQUE NOT NULL,
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID) ON DELETE CASCADE,
    FOREIGN KEY (PaymentMethod) REFERENCES PaymentMethods(MethodID) ON DELETE SET NULL,
    FOREIGN KEY (PaymentStatus) REFERENCES PaymentStatus(StatusID) ON DELETE SET NULL
);

-- PaymentLogs Table
CREATE TABLE PaymentLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    LogMessage TEXT NOT NULL
);

-- BankDetails Table
CREATE TABLE BankDetails (
    BankDetailID INT AUTO_INCREMENT PRIMARY KEY,
    BankName VARCHAR(255) NOT NULL,
    AccountNumber BIGINT UNIQUE NOT NULL,
    IBAN VARCHAR(34) UNIQUE NOT NULL,
    BIC VARCHAR(11) UNIQUE NOT NULL
);
