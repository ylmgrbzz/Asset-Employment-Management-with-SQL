
--varlık tablosu

CREATE TABLE Asset (
    AssetID INT PRIMARY KEY IDENTITY,
    AssetName NVARCHAR(255) NOT NULL,
    SerialNumber NVARCHAR(255) NOT NULL,
    PurchaseDate DATE NOT NULL,
    WarrantyDate DATE NOT NULL
);


--Depo Tablosu
CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY IDENTITY,
    WarehouseName NVARCHAR(255) NOT NULL,
    Location NVARCHAR(255) NOT NULL
);


--Kullanıcı Tablosu

CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY,
    UserName NVARCHAR(255) NOT NULL,
    Department NVARCHAR(255) NOT NULL
);


--Zimmet Tablosu

CREATE TABLE Assignment (
    AssignmentID INT PRIMARY KEY IDENTITY,
    AssetID INT NOT NULL FOREIGN KEY REFERENCES Asset(AssetID),
    UserID INT NOT NULL FOREIGN KEY REFERENCES [User](UserID),
    WarehouseID INT NOT NULL FOREIGN KEY REFERENCES Warehouse(WarehouseID),
    AssignmentDate DATE NOT NULL,
    ReturnDate DATE
);


-- Rol Tablosu

CREATE TABLE Role (
    RoleID INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(255) NOT NULL
);

-- KullanıcıRol Tablosu


CREATE TABLE UserRole (
    UserRoleID INT PRIMARY KEY IDENTITY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES [User](UserID),
    RoleID INT NOT NULL FOREIGN KEY REFERENCES Role(RoleID)
);
