CREATE DATABASE SQLTrainingDB;
USE SQLTrainingDB;
GO

CREATE TABLE TransactionAccounts
(
    AccountID INT PRIMARY KEY,
    AccountName VARCHAR(50),
    Balance DECIMAL(10, 2)
);

INSERT INTO TransactionAccounts
VALUES
    (1, 'Alice', 5000.00),
    (2, 'Bob', 3000.00);

SELECT *
FROM TransactionAccounts;
-------------- TRANSACTION-------------

BEGIN Transaction;

UPDATE TransactionAccounts
SET [Balance]=4500
WHERE [AccountID] = 1;

SELECT * FROM [TransactionAccounts];
COMMIT TRANSACTION

SELECT * FROM [TransactionAccounts];
------------------------------------
BEGIN TRANSACTION ;
UPDATE [TransactionAccounts]
SET [Balance] = 2000
WHERE [AccountID]=2;

SELECT * FROM [TransactionAccounts];

ROLLBACK TRANSACTION;

SELECT * FROM [TransactionAccounts];

-------------------------------

BEGIN TRY
BEGIN TRANSACTION
UPDATE [TransactionAccounts]
SET [Balance] = [Balance]-500
WHERE [AccountID] =1;

UPDATE [TransactionAccounts]
 SET [Balance] = [Balance]+500
 WHERE [AccountID] =2;

 COMMIT TRANSACTION;
 PRINT 'Transaction is Successful';
 END TRY
 BEGIN CATCH
 IF @@TRANCOUNT>0
 ROLLBACK TRANSACTION;
 SELECT ERROR_MESSAGE() as ErrorMessage;
 END CATCH;
 SELECT * FROM [TransactionAccounts];

 --------------------------------------------


 BEGIN TRY
 BEGIN TRANSACTION;
 UPDATE [TransactionAccounts]
 SET [Balance] = [Balance]-100
 WHERE [AccountID]=1;
 UPDATE [TransactionAccounts]
 SET [Balance] = 'Invalid'
 WHERE [AccountID]=2;
 COMMIT TRANSACTION;
 PRINT 'Transaction commited succfully';
 END TRY
 BEGIN CATCH
 IF @@TRANCOUNT>0
 ROLLBACK TRANSACTION;
 PRINT 'Trancation failed so the transaction is rollback';
 SELECT ERROR_MESSAGE() AS ErrorMessage;
 END CATCH;
 SELECT * FROM [TransactionAccounts];

 ------------------@@ERROR------------

 USE SQLTrainingDB;
GO

CREATE TABLE ErrorDemo
(
    ID INT PRIMARY KEY,
    ProductName VARCHAR(50)
);

INSERT INTO ErrorDemo
VALUES (1, 'Laptop');

SELECT * FROM [ErrorDemo];
-----------------------

BEGIN TRANSACTION;

INSERT INTO [ErrorDemo] VALUES (2,'Keyword');

IF @@ERROR>0
BEGIN
ROLLBACK TRANSACTION;
PRINT 'Error occured, transaction rolled back';
END

ELSE
BEGIN
COMMIT TRANSACTION ;
PRINT 'Transaction commited successfully';
END;
SELECT * FROM [ErrorDemo];

-----------------------

BEGIN TRANSACTION;

INSERT INTO [ErrorDemo] VALUES (1,'Mouse');

IF @@ERROR>0
BEGIN 
ROLLBACK TRANSACTION;
PRINT 'Error occured, transaction rolled back';
END

ELSE 
BEGIN
COMMIT TRANSACTION ;
PRINT 'Transaction commited successfully';
END;
SELECT * FROM [ErrorDemo];
------------------------------------

USE SQLTrainingDB;
GO

CREATE TABLE TransactionProductDemo
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Quantity INT
);

INSERT INTO TransactionProductDemo
VALUES (1, 'Mouse', 10);

SELECT *
FROM TransactionProductDemo;
---------------------
SET XACT_ABORT ON;
BEGIN TRY
BEGIN TRANSACTION;
INSERT INTO [TransactionProductDemo] VALUES (2,'Keyword',20);

UPDATE [TransactionProductDemo]
SET [Quantity]='Ten'
WHERE [ProductID] =1;
COMMIT TRANSACTION;
END TRY

BEGIN CATCH
  IF XACT_STATE() <> 0
  ROLLBACK TRANSACTION;

  SELECT ERROR_MESSAGE() AS ErrorMessage;
  END CATCH;

  SELECT * FROM [TransactionProductDemo];

  --------------------------
  USE SQLTrainingDB;

  BEGIN TRANSACTION ;

  INSERT INTO [TransactionProductDemo]
  VALUES (2,'Keyword',20);

  SAVE TRANSACTION BeforeMonitor;

  INSERT INTO [TransactionProductDemo]
  VALUES (3,'Monitor',15);

  SELECT * FROM [TransactionProductDemo];

  ROLLBACK TRANSACTION BeforeMonitor;

  COMMIT TRANSACTION;

  SELECT * FROM [TransactionProductDemo];

  ---------------------------

  USE SQLTrainingDB

  BEGIN TRANSACTION AddProductTxn;

  INSERT INTO [TransactionProductDemo] VALUES (3,'Monitor',15);

  UPDATE [TransactionProductDemo]
  SET [ProductName]='Gaming Keyword'
  WHERE [ProductID] =2;

  COMMIT TRANSACTION AddProductTxn;

  SELECT * FROM [TransactionProductDemo];