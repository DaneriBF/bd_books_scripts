USE BdTest;
GO

DROP FUNCTION IF EXISTS [Operations].fnShowBookStatus;
GO
/*
  Mostrar el estado de un libro (Prestado o Disponible) utilizando una función escalar.
  @param idBook: El ID del libro a verificar.
  @return: 'Prestado' si el libro está actualmente prestado, 'Disponible' si no lo está.
*/
CREATE FUNCTION [Operations].fnShowBookStatus (@idBook INT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @status NVARCHAR(20);

    IF EXISTS (
      SELECT idBook FROM [Catalog].tblBooks WHERE idBook = @idBook
    )
      --Si existe el valor 1, el libro está prestado, de lo contrario, está disponible
      IF EXISTS (
        --Retorna 1 si encuentra un préstamo activo para el libro (es decir, un registro en tblLoans con returnDate NULL)
          SELECT 1 AS IsBorrowed FROM Operations.tblLoans WHERE idBook = @idBook AND returnDate IS NULL
      )
          SET @status = 'Prestado';
      ELSE
          SET @status = 'Disponible';

    RETURN @status;
END;
GO

SELECT [Operations].fnShowBookStatus(0) AS Status;
SELECT [Operations].fnShowBookStatus(5) AS Status;
SELECT [Operations].fnShowBookStatus(4) AS Status;
