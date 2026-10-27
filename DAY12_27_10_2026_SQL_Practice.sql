BEGIN TRY
    PRINT 'Outer TRY started';

    BEGIN TRY
        SELECT 10 / 0 AS Result;
    END TRY
    BEGIN CATCH
        PRINT 'Inner error handled';
    END CATCH;

    PRINT 'Program continues';
END TRY
BEGIN CATCH
    PRINT 'Outer error handled';
END CATCH;

--------------STORED PROCEDURE WITH TRY CATCH--------------

USE SQLTrainingDB;

CREATE PROCEDURE spdivide
       @a DECIMAL(10,2),
       @b DECIMAL(10,2),
       @c DECIMAL(10,2) OUTPUT

AS
BEGIN
  BEGIN TRY
    SET @c=@a/@b;
    END TRY
    BEGIN CATCH
      SELECT ERROR_NUMBER() AS errorNumber,
      ERROR_MESSAGE() AS errorMessage,
      ERROR_SEVERITY() AS errorSeverity,
      ERROR_STATE() AS errorState,
      ERROR_PROCEDURE() AS errorProcedure,
      ERROR_LINE() AS errorLine
    END CATCH;
END;

DECLARE @result DECIMAL(10,2)
EXEC spdivide
10,2, @result OUTPUT;
PRINT @result;


DECLARE @result DECIMAL(10,2)
EXEC spdivide 10,0, @result OUTPUT;
PRINT @result;

----------------------------------------------------

SET XACT_ABORT ON;

BEGIN TRY
  BEGIN TRANSACTION;
   UPDATE TransactionProductDemo
   SET [Quantity]='Ten'
   WHERE [ProductID] = 1
   COMMIT TRANSACTION;
END TRY
BEGIN CATCH

  SELECT XACT_STATE() AS xactState,
  ERROR_MESSAGE() AS errorMessage;

  IF XACT_STATE() <> 0
  BEGIN
   ROLLBACK TRANSACTION;
   PRINT 'Transaction rolled back';
  END;
END CATCH;
----------------- TRANSACTION EITH TRY CATCH---------------

USE SQLTrainingDB;
GO

CREATE TABLE dbo.TryCatchPersons
(
    PersonID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.TryCatchDeals
(
    DealID INT PRIMARY KEY IDENTITY(1,1),
    PersonID INT NOT NULL,
    DealNote NVARCHAR(100),
    FOREIGN KEY (PersonID)
        REFERENCES dbo.TryCatchPersons(PersonID)
);

-- Add two people
INSERT INTO dbo.TryCatchPersons (FirstName, LastName)
VALUES
    ('John', 'Doe'),
    ('Jane', 'Doe');

-- John has a related deal
INSERT INTO dbo.TryCatchDeals (PersonID, DealNote)
VALUES (1, 'Deal for John Doe');

-- Check the data
SELECT * FROM dbo.TryCatchPersons;
SELECT * FROM dbo.TryCatchDeals;
-------------------------------------------------------

CREATE OR ALTER PROCEDURE spdeleteTryCatchPerson
@PersonID INT
AS
BEGIN
 SET NOCOUNT ON;

 BEGIN TRY
 BEGIN TRANSACTION;
 DELETE FROM TryCatchPersons
 WHERE [PersonID] = @PersonID
 COMMIT TRANSACTION;
 PRINT 'Person deleted successfully';
 END TRY
 BEGIN CATCH
 DECLARE @state INT = XACT_STATE();
 IF @state <> 0 
 ROLLBACK TRANSACTION;
 PRINT 'Delete failed; transaction rolled back';

 SELECT ERROR_MESSAGE() AS errorMessage,
 ERROR_NUMBER() AS errorNumber,
 @state AS TransactionStateBeforeRollback;
 END CATCH;
 END;

 EXEC spdeleteTryCatchPerson @PersonID =2;
 SELECT * FROM [TryCatchPersons];

 EXEC dbo.spDeleteTryCatchPerson @PersonID = 1;

SELECT *
FROM dbo.TryCatchPersons;

SELECT *
FROM dbo.TryCatchDeals;
---------------

RAISERROR('Whoops, an error occured',1,1);

RAISERROR ('Invalid employee details',16,1);

/*Write a TRY...CATCH query that raises 'Invalid salary entered' with severity 16 and state 1.
Inside the CATCH block, display only the error message using ERROR_MESSAGE().*/

BEGIN TRY
RAISERROR('Invalid salary entered',16,1);
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() AS errormessage;
END CATCH;

/*Write a RAISERROR statement using a variable named @MessageText to display:

Invalid employee ID: 105

Use %s as the placeholder, severity 16, and state 1.*/

DECLARE @messageTxt NVARCHAR(100)
SET @messageTxt = N'Invalid employee ID: %s';

RAISERROR(@messageTxt,16,1,N'105');