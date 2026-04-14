USE BdTest;
GO





SELECT * FROM Operations.tblLoans;
SELECT 1 AS IsLoan FROM Operations.tblLoans WHERE idBook = 0 AND returnDate IS NULL
SELECT idBook FROM Catalog.tblBooks WHERE idBook = 0;

SELECT * FROM sys.objects 
WHERE name = 'fnShowBookStatus' 
  AND schema_id = SCHEMA_ID('Operations')
  AND type IN ('FN', 'IF', 'TF'); -- FN=Scalar, IF=Inline table, TF=Table-valued