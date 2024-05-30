INSERT INTO Asset (AssetName, SerialNumber, PurchaseDate, WarrantyDate)
VALUES 
('Laptop', 'SN123456', '2022-01-15', '2024-01-15'),
('Projector', 'SN654321', '2021-05-20', '2023-05-20');

INSERT INTO Warehouse (WarehouseName, Location)
VALUES 
('Main Warehouse', 'Building A'),
('Secondary Warehouse', 'Building B');

INSERT INTO [User] (UserName, Department)
VALUES 
('John Doe', 'IT'),
('Jane Smith', 'Finance');
('Alice Johnson', 'Sales');


INSERT INTO Assignment (AssetID, UserID, WarehouseID, AssignmentDate, ReturnDate)
VALUES 
(1, 1, 1, '2023-03-01', NULL),
(2, 2, 2, '2023-04-15', '2024-01-01');


INSERT INTO Role (RoleName)
VALUES 
('Personel'),
('Müşteri');


INSERT INTO [User] (UserName, Department)
VALUES 
('John Doe', 'IT'),
('Jane Smith', 'Finance'),
('Alice Johnson', 'Sales');

INSERT INTO UserRole (UserID, RoleID)
VALUES 
(1, 1),  -- John Doe -> Personel
(2, 1),  -- Jane Smith -> Personel
(3, 2);  -- Alice Johnson -> Müşteri


