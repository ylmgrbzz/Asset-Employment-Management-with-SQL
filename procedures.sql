-- Varlık Ekleme Prosedürü

CREATE PROCEDURE AddAsset
    @AssetName NVARCHAR(255),
    @SerialNumber NVARCHAR(255),
    @PurchaseDate DATE,
    @WarrantyDate DATE
AS
BEGIN
    INSERT INTO Asset (AssetName, SerialNumber, PurchaseDate, WarrantyDate)
    VALUES (@AssetName, @SerialNumber, @PurchaseDate, @WarrantyDate);
END;


-- Zimmet Atama Prosedürü


CREATE PROCEDURE AssignAsset
    @AssetID INT,
    @UserID INT,
    @WarehouseID INT,
    @AssignmentDate DATE
AS
BEGIN
    INSERT INTO Assignment (AssetID, UserID, WarehouseID, AssignmentDate)
    VALUES (@AssetID, @UserID, @WarehouseID, @AssignmentDate);
END;


--- Toplam Varlık Sayısı Raporu
CREATE PROCEDURE TotalAssetsReport
AS
BEGIN
    SELECT COUNT(*) AS TotalAssets FROM Asset;
END;

-- Kullanıcı Ekleme Prosedürü
CREATE PROCEDURE AddUser
    @UserName NVARCHAR(255),
    @Department NVARCHAR(255)
AS
BEGIN
    INSERT INTO [User] (UserName, Department)
    VALUES (@UserName, @Department);
END;

-- Depo Ekleme Prosedürü
CREATE PROCEDURE AddWarehouse
    @WarehouseName NVARCHAR(255),
    @Location NVARCHAR(255)
AS
BEGIN
    INSERT INTO Warehouse (WarehouseName, Location)
    VALUES (@WarehouseName, @Location);
END;

-- Rol Ekleme Prosedürü
CREATE PROCEDURE AddRole
    @RoleName NVARCHAR(255)
AS
BEGIN
    INSERT INTO Role (RoleName)
    VALUES (@RoleName);
END;

-- Kullanıcıya Rol Atama Prosedürü
CREATE PROCEDURE AssignRole
    @UserID INT,
    @RoleID INT
AS
BEGIN
    INSERT INTO UserRole (UserID, RoleID)
    VALUES (@UserID, @RoleID);
END;

-- Kullanıcıların Rol Bilgilerini Getirme Prosedürü
CREATE PROCEDURE GetUserRoles
    @UserID INT
AS
BEGIN
    SELECT RoleName FROM Role
    JOIN UserRole ON Role.RoleID = UserRole.RoleID
    WHERE UserID = @UserID;
END;

-- Kullanıcıların Zimmetli Varlıklarını Getirme Prosedürü
CREATE PROCEDURE GetUserAssignedAssets
    @UserID INT
AS
BEGIN
    SELECT AssetName, SerialNumber, AssignmentDate, ReturnDate
    FROM Asset
    JOIN Assignment ON Asset.AssetID = Assignment.AssetID
    WHERE UserID = @UserID;
END;

-- Depodaki Varlıkları Getirme Prosedürü
CREATE PROCEDURE GetWarehouseAssets
    @WarehouseID INT
AS
BEGIN
    SELECT AssetName, SerialNumber, AssignmentDate, ReturnDate
    FROM Asset
    JOIN Assignment ON Asset.AssetID = Assignment.AssetID
    WHERE WarehouseID = @WarehouseID;
END;

-- Depodaki Varlıkların Sayısını Getirme Prosedürü
CREATE PROCEDURE GetWarehouseAssetCount
    @WarehouseID INT
AS
BEGIN
    SELECT COUNT(*) AS TotalAssets FROM Assignment
    WHERE WarehouseID = @WarehouseID;
END;

-- Depodaki Varlıkların Toplam Değerini Getirme Prosedürü
CREATE PROCEDURE GetWarehouseAssetValue
    @WarehouseID INT
AS
BEGIN
    SELECT SUM(AssetValue) AS TotalValue FROM Asset
    JOIN Assignment ON Asset.AssetID = Assignment.AssetID
    WHERE WarehouseID = @WarehouseID;
END;


--Zimmet Raporu
CREATE PROCEDURE AssignmentReport
AS
BEGIN
    SELECT 
        A.AssetName, U.UserName, W.WarehouseName, Asgn.AssignmentDate, Asgn.ReturnDate
    FROM 
        Assignment Asgn
    JOIN Asset A ON Asgn.AssetID = A.AssetID
    JOIN [User] U ON Asgn.UserID = U.UserID
    JOIN Warehouse W ON Asgn.WarehouseID = W.WarehouseID;
END;


--İptal Edilen Zimmet Raporu

CREATE PROCEDURE CanceledAssignmentsReport
AS
BEGIN
    SELECT 
        YEAR(ReturnDate) AS Year, MONTH(ReturnDate) AS Month, COUNT(*) AS CanceledAssignments
    FROM 
        Assignment
    WHERE 
        ReturnDate IS NOT NULL
        AND ReturnDate >= DATEADD(YEAR, -2, GETDATE())
    GROUP BY 
        YEAR(ReturnDate), MONTH(ReturnDate);
END;




